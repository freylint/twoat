{ config, nix, pkgs, inputs, ... }: let
  inherit (inputs) home-manager nur sops-nix disko;
in {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ nur.overlay ];
  };
  system.stateVersion = "24.05";

  imports = [
    home-manager.nixosModules.home-manager
    sops-nix.nixosModules.sops
    disko.nixosModules.disko
    ../components/bootable.nix
  ];

  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
  ];

  users.users.gen = {
    isNormalUser = true;
    # TODO switch back to sops passwords
    initialPassword = "corecthorsebatterystaple";
    extraGroups = [ "wheel" "seat" "video" "audio" "libvirtd" "disks" "docker" "dialout" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.gen.home.stateVersion = "24.05";
    sharedModules = [
      sops-nix.homeManagerModules.sops
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
