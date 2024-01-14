{ pkgs, environment, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    amdvlk
  ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [amdvlk];
    extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
  };
}
