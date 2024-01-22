{ environment, pkgs, ... }:
{
  imports = [
    ../components/gui.nix
    ../components/tweaks.nix
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
