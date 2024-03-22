{ config, pkgs, inputs, ... }:
{
  imports = [
    ../components/gui.nix
    ../components/tweaks.nix
    ../components/sound.nix
    ../components/networked.nix
    ../components/web.nix
    ../components/office.nix
  ];

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
