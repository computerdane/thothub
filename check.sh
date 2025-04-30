# check.sh
#
# Ensures that the "thots" NixOS module has a valid configuration and that all
# lib tests pass.

set -eou pipefail

nix flake check
nix eval .#evalModule.config.thots "$@" >/dev/null
nix eval .#lib.testsPassed "$@" >/dev/null
