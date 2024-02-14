#!/usr/bin/env sh

NIX_EXPER="nix \
            --extra-experimental-features nix-command \
            --extra-experimental-features flakes"
NIXOS_ANYWHERE_URL="github:nix-community/nixos-anywhere"
alias nixa="${NIX_EXPER} run ${NIXOS_ANYWHERE_URL} --"

case $1 in
  "rebuild")
    nixos-rebuild switch --flake ${2}
  ;;
  "gdw.test")
    nixa --flake .#gdw --vm-test
  ;;
  "gdw.local")
    nixa --flake .#gdw root@localhost
  ;;
  "ghl.local")
    nixa --flake .#ghl root@localhost
  ;;
  "ghl")
    nixa --flake .#ghl root@192.168.1.190
  ;;
  *)
    echo "Please specify a target configuration and host."
  ;;
esac
