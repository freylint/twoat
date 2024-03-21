{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    # include NixOS-WSL modules
    inputs.nixos-wsl
  ];

  wsl = {
    enable = true;
    wsl.defaultUser = "nixos";
  };

  system.stateVersion = "23.11";
}
