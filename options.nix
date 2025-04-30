/*
  options.nix

  The base options schema for the users/${name}.nix files.
*/

lib: with lib; {

  githubId = mkOption {
    description = "User's GitHub ID from https://api.github.com/users/{username}";
    type = types.int;
  };

  sshKeys = mkOption {
    description = "Set of user's SSH public keys";
    default = [ ];
    type = types.attrsOf types.singleLineStr;
  };

  minecraftAccounts = mkOption {
    default = [ ];
    type = types.listOf (
      types.submodule {
        options = {

          name = mkOption {
            description = "User's Minecraft [username](https://minecraft.wiki/w/Player#Username)";
            type = types.strMatching "^[a-zA-Z0-9_]{3,16}";
          };

          uuid = mkOption {
            description = "User's Minecraft [UUID](https://minecraft.wiki/w/UUID)";
            type = types.strMatching "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$";
          };

        };
      }
    );
  };

  hashedPassword = mkOption {
    description = "Specifies the hashed password for the user. See {option}`users.users.<name>.hashedPassword`";
    default = null;
    type = with types; nullOr (passwdEntry str);
  };

  shell = mkOption {
    description = "User's preferred shell";
    default = "fish";
    type = types.enum [
      "bash"
      "fish"
      "zsh"
    ];
  };

  wireguardPeers = mkOption {
    description = "Basic information needed to peer with others using WireGuard";
    default = [ ];
    type = types.listOf (
      types.submodule {
        options = {

          Endpoint = mkOption {
            description = "Endpoint of WireGuard server";
            example = "example.com:51820";
            type = types.str;
          };

          PublicKey = mkOption {
            description = "WireGuard public key";
            example = "AmjREu51OzcQRvwLJ81+Nw0EJr9GmxQlRnUMSZOElBQ=";
            type = types.str;
          };

          AllowedIPs = mkOption {
            description = "List of IPv4/IPv6 CIDRs that other peers are allowed to access through the tunnel";
            example = [
              "10.0.0.1/24"
              "fd00:100::/32"
            ];
            type = types.listOf types.str;
          };

        };
      }
    );
  };

}
