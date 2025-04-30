/*
  lib.nix

  Exports some helper functions that handle common use cases for end users.
*/

{ lib }:
let
  inherit (builtins) map;
  inherit (lib) flatten;
in
rec {
  /**
    Maps a list of thots to a list that matches the schema of Minecraft's
    ops.json. Use builtins.toJSON to convert the result to actual JSON.

    # Inputs

    `thots`

    : A list of thots from {option}`config.thots`

    # Type

    ```
    toMinecraftOps :: [AttrSet] -> [AttrSet]
    ```

    # Example
    :::{.example}
    ## `thothub.lib.toMinecraftOps` usage example

    ```
    toMinecraftOps (with config.thots; [ dane scott ])
    => [ { bypassesPlayerLimit = true; level = 4; name = "Dane47"; uuid = "6cfede5c-8117-4673-bd7d-0a17bbab69e2"; } { bypassesPlayerLimit = true; level = 4; name = "ipv6_dotsh"; uuid = "33879815-699c-4a15-b04c-2dce27a570be"; } ]
    ```
  */
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

  # Unit tests for our lib functions
  runTests = lib.runTests {
    test_toMinecraftOps = {
      expr = toMinecraftOps [
        {
          minecraftAccounts = [
            {
              name = "Dane47";
              uuid = "6cfede5c-8117-4673-bd7d-0a17bbab69e2";
            }
          ];
        }
        {
          minecraftAccounts = [
            {
              name = "ipv6_dotsh";
              uuid = "33879815-699c-4a15-b04c-2dce27a570be";
            }
          ];
        }
      ];
      expected = [
        {
          bypassesPlayerLimit = true;
          level = 4;
          name = "Dane47";
          uuid = "6cfede5c-8117-4673-bd7d-0a17bbab69e2";
        }
        {
          bypassesPlayerLimit = true;
          level = 4;
          name = "ipv6_dotsh";
          uuid = "33879815-699c-4a15-b04c-2dce27a570be";
        }
      ];
    };
  };

  # Can be used to check if tests pass
  testsPassed = if runTests == [ ] then true else throw "Tests did not pass!";
}
