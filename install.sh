#!/usr/bin/env sh

NIX_EXPER="nix \
            --extra-experimental-features nix-command \
            --extra-experimental-features flakes"
NIXOS_ANYWHERE="github:nix-community/nixos-anywhere"

case $1 in
  "gdw.vm")
    ${NIX_EXPER} run ${NIXOS_ANYWHERE} -- --flake .#gdw --vm-test
  ;;
esac
