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
    Selects a property for each thot and collects them in a list.

    # Inputs

    `key`

    : An attribute of {option}`config.thots.<name>`

    `thots`

    : A list of thots from {option}`config.thots.<name>`

    # Type

    ```
    String -> [AttrSet] -> [Any]
    ```

    # Example
    ## `thothub.lib.select` usage example

    ```
    select "shell" (builtins.attrValues config.thots)
    => [ "fish" "fish" "zsh" "bash" ]
    ```
  */
  select = key: thots: map (thot: thot.${key}) thots;

  /**
    Selects a property for each thot and collects them in a flattened list.

    # Inputs

    `key`

    : An attribute of {option}`config.thots.<name>`

    `thots`

    : A list of thots from {option}`config.thots.<name>`

    # Type

    ```
    String -> [AttrSet] -> [Any]
    ```

    # Example
    ## `thothub.lib.flatSelect` usage example

    ```
    flatSelect "sshKeysList" (builtins.attrValues config.thots)
    => [ "ed25519 AAAA...." "ed25519 AAAA...." "ed25519 AAAA...." "ed25519 AAAA...." ]
    ```
  */
  flatSelect = key: thots: flatten (map (thot: thot.${key}) thots);

  /**
    Maps a user's Minecraft account to an entry in a server's ops.json file.

    # Inputs

    `acct`

    : A Minecraft account from {option}`config.thots.<name>.minecraftAccounts`

    # Type

    ```
    AttrSet -> AttrSet
    ```

    # Example
    ## `thothub.lib.toMinecraftOp` usage example

    ```
    toMinecraftOp (builtins.elemAt config.thots.dane.minecraftAccounts 0)
    => { bypassesPlayerLimit = true; level = 4; name = "Dane47"; uuid = "6cfede5c-8117-4673-bd7d-0a17bbab69e2"; }
    ```
  */
  toMinecraftOp =
    acct:
    acct
    // {
      level = 4;
      bypassesPlayerLimit = true;
    };

  /**
    Maps a list of Minecraft accounts to a list that matches the schema of
    Minecraft's ops.json.

    Use builtins.toJSON to convert the result to actual JSON.

    # Inputs

    `accts`

    : A list of Minecraft accounts from {option}`config.thots.<name>.minecraftAccounts`

    # Type

    ```
    toMinecraftOps :: [AttrSet] -> [AttrSet]
    ```

    # Example
    ## `thothub.lib.toMinecraftOps` usage example

    ```
    toMinecraftOps (flattenMinecraftAccounts (with config.thots; [ dane scott ]))
    => [ { bypassesPlayerLimit = true; level = 4; name = "Dane47"; uuid = "6cfede5c-8117-4673-bd7d-0a17bbab69e2"; } { bypassesPlayerLimit = true; level = 4; name = "ipv6_dotsh"; uuid = "33879815-699c-4a15-b04c-2dce27a570be"; } ]
    ```
  */
  toMinecraftOps = map (acct: toMinecraftOp acct);

  # Tests for our lib functions
  runTests = lib.runTests {

    test_toMinecraftOps_with_flatSelect = {
      expr = toMinecraftOps (
        flatSelect "minecraftAccounts" [
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
        ]
      );
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
