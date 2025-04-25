# check.sh
#
# Ensures that the "thots" NixOS module has a valid configuration.

nix eval .#evalModule "$@" >/dev/null
