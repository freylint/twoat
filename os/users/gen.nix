{ inputs, lib, config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.variables.EDITOR = "nvim";

  users.users.gen = {
    isNormalUser = true;
    initialPassword = "correcthorsebatterystaple";
    extraGroups = [ "wheel" "seat" "video" "audio" ];
  };


}
