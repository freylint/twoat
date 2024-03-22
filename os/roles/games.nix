{ environment, pkgs, ... }:
{
  imports = [
    ../components/gui.nix
    ../components/tweaks.nix
  ];

  environment.systemPackages = with pkgs; [
    heroic
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
