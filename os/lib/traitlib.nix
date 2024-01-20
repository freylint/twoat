{ home-manager, ... }:

{
  # Converts a home manager module to an OS module.
  hMantoOs = modulePath: {
    home-manager.nixosModules.home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.gen = { config, pkgs, ... }: {
        imports = [ import modulePath ];
      };
    };
  };
}