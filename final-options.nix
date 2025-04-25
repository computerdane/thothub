/*
  final-options.nix

  The final options schema for the `config.thots` attribute. This includes some
  auto-generated attributes for convenience.
*/

lib:
with lib;
(import ./options.nix lib)
// {

  name = mkOption {
    description = "User's username";
    type = types.passwdEntry types.str;
    apply =
      x:
      assert (
        stringLength x < 32 || abort "Username '${x}' is longer than 31 characters which is not allowed!"
      );
      x;
  };

  sshKeysList = mkOption {
    description = "List of user's SSH public keys";
    type = types.listOf types.singleLineStr;
  };

}
