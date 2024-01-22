{ config, pkg, inputs, ... }:
{
  imports = [
    ../components/git.nix
    ../components/gui.nix
    ../components/vscode.nix
    ../components/virt.nix
    ../components/suid.nix
  ];
}
