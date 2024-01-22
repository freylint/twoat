{ nix, pkgs, inputs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nur.overlay
    ];
  };
  system.stateVersion = "23.11";

  networking.hostName = "gdw";
  time.timeZone = "America/New_York";

  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nur.hmModules.nur
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

  inputs.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.gen.home.stateVersion = "23.11";
    extraSpecialArgs = { inherit inputs; };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
