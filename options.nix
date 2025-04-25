/*
  options.nix

  The base options schema for the users/${name}.nix files.
*/

lib: with lib; {

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
    default = null;
    type = with types; nullOr (passwdEntry str);
    description = "Specifies the hashed password for the user. See {option}`users.users.<name>.hashedPassword`";
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

}
