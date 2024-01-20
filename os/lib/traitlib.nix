{ lib, home-manager, ... }:
{
  # Converts a home-manager module to an OS module.
  hMantoOsMod = modulePath: {
    inherit outputs;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.gen = { config, pkgs, ... }: {
        imports = [ import modulePath];
      };
    };
  };
}