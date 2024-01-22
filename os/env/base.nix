{ nix, pkgs, home-manager, nur, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      nur.overlay
    ];
  };
  system.stateVersion = "23.11";

  networking.hostName = "gdw";
  time.timeZone = "America/New_York";

  imports = [
    home-manager.nixosModules.home-manager
    nur.hmModules.nur
  ];

  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
    firefox
  ];

  users.users.gen = {
    isNormalUser = true;
    initialPassword = "correcthorsebatterystaple";
    extraGroups = [ "wheel" "seat" "video" "audio" ];
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
