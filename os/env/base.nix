{ nix, pkgs, home-manager, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "unstable";

  networking.hostName = "gdw";
  time.timeZone = "America/New_York";

  imports = [
    home-manager.nixosModules.home-manager
  ];

  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
  ];

  users.users.gen = {
    isNormalUser = true;
    initialPassword = "correcthorsebatterystaple";
    extraGroups = [ "wheel" "seat" "video" "audio" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.gen.home.stateVersion = "unstable";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
