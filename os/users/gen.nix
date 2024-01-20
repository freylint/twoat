{ inputs, lib, config, pkgs, home-manager, ... }:
{
  imports = [
    {
      nixpkgs.config.allowUnfree = true;
      environment.variables.EDITOR = "nvim";

      users.users.gen = {
        isNormalUser = true;
        initialPassword = "correcthorsebatterystaple";
        extraGroups = [ "wheel" "seat" "video" "audio" ];
      };
    }
  ];
}
