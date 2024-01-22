{ nix, pkgs, inputs, ... }: let
  inherit (inputs) home-manager nur;
in {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ nur.overlay ];
  };
  system.stateVersion = "23.11";

  imports = [
    home-manager.nixosModules.home-manager
    ../components/bootable.nix
  ];

  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
  ];

  users.users.gen = {
    isNormalUser = true;
    initialPassword = "correcthorsebatterystaple";
    extraGroups = [ "wheel" "seat" "video" "audio" "libvirtd" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.gen.home.stateVersion = "23.11";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
