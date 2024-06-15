{ pkgs, environment, config, ... }:
{
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [amdvlk];
      extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = false;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  environment.systemPackages = with pkgs; [
    amdvlk
  ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

}
