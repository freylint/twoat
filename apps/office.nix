{ environment, pkgs, lib, ... }:
{
  # Install standard word processing fonts
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];

  fonts.packages= with pkgs; [
    corefonts
  ];

  environment.systemPackages = with pkgs; [
    onlyoffice-bin
  ];
}