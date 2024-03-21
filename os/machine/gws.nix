{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    # include NixOS-WSL modules
    inputs.nixos-wsl.modules
  ];

  wsl = {
    enable = true;
    wsl.defaultUser = "nixos";
  };

  system.stateVersion = "23.11";
}
