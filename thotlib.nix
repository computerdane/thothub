/*
  thotlib.nix

  Reads the users/${name}.nix files and creates an attribute set from them.
  Exports a helper function to make the NixOS module options.
*/

let
  inherit (builtins)
    attrNames
    filter
    listToAttrs
    map
    readDir
    replaceStrings
    ;

  # Get list of files in ./users
  entries = readDir ./users;
  entryList = map (name: {
    inherit name;
    value = entries.${name};
  }) (attrNames entries);
  filesList = filter ({ value, ... }: value == "regular") entryList;

  # Map files to a list of names (remove .nix extension) and values
  thotsList = map (
    { name, ... }:
    let
      username = replaceStrings [ ".nix" ] [ "" ] name;
    in
    {
      name = username;
      value = import "${./users}/${name}";
    }
  ) filesList;
in
{
  # Attrset that maps ${name} -> import ./users/${name}.nix
  thots = listToAttrs thotsList;

  # Wrapper to make options.thots
  mkOptions =
    path: lib:
    with lib;
    mkOption {
      default = { };
      type = types.attrsOf (
        types.submodule {
          options = import path lib;
        }
      );
    };
}
