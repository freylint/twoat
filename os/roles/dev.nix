{ config, pkgs, inputs, ... }:
{
  imports = [
    ../components/git.nix
    ../components/gui.nix
    ../components/tweaks.nix
    ../components/vscode.nix
    ../components/virt.nix
    ../components/suid.nix
  ];

  environment.systemPackages = with pkgs; [
    sops
    age
  ];
}
