/*
  flake.nix

  Outputs the "thots" NixOS module that exports information about all the users
  in this repo.
*/

{
  inputs.nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";

  outputs =
    { self, nixpkgs-lib }:
    let
      thotlib = import ./thotlib.nix;
      lib = nixpkgs-lib.lib;
    in
    {
      nixosModules.thots =
        { config, lib, ... }:
        {
          # Construct base config
          options._thots = thotlib.mkOptions ./options.nix lib;
          config._thots = thotlib.thots;

          # Add extra auto-generated attributes for convenience
          options.thots = thotlib.mkOptions ./final-options.nix lib;
          config.thots = builtins.mapAttrs (
            name: thot:
            thot
            // {
              inherit name;
              sshKeysList = builtins.attrValues thot.sshKeys;
            }
          ) config._thots;
        };

      lib = import ./lib.nix { inherit lib; };

      # Use with `nix eval` to ensure the NixOS module is valid
      eval.module = lib.evalModules { modules = [ self.nixosModules.thots ]; };

    };
}
