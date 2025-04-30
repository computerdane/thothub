# check.sh
#
# Ensures that the "thots" NixOS module has a valid configuration.

set -eou pipefail

nix flake check
nix eval .#evalModule.config.thots "$@" >/dev/null
