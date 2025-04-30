{ lib }:
let
  inherit (builtins) map;
  inherit (lib) flatten;
in
{
  toMinecraftOps =
    thots:
    flatten (
      map (
        thot:
        map (
          acct:
          acct
          // {
            level = 4;
            bypassesPlayerLimit = true;
          }
        ) thot.minecraftAccounts
      ) thots
    );
}
