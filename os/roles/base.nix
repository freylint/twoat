{ config, nix, pkgs, inputs, ... }: let
  inherit (inputs) home-manager nur sops-nix;
in {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ nur.overlay ];
  };
  system.stateVersion = "23.11";

  imports = [
    home-manager.nixosModules.home-manager
    sops-nix.nixosModules.sops
    ../components/bootable.nix
  ];

  # TODO Move sops configuration into module
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    # TODO support multiple users
    age.keyFile = "/home/gen/.config/sops/age/keys.txt";
  };

  sops.secrets."users/gen" = {};

  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
  ];

  users.users.gen = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."users/gen".path;
    extraGroups = [ "wheel" "seat" "video" "audio" "libvirtd" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.gen.home.stateVersion = "23.11";
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
