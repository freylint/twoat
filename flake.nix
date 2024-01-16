{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    freyqf = {
      url = "./projects/freyqf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, freyqf, ... }@inputs:
    let inherit (self) outputs;
    in {
      nixosConfigurations = {
        "gdw" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            {
              networking.hostName = "gdw";
              time.timeZone = "America/New_York";

              system.stateVersion = "23.11";
            }
            ./os/machine/gdw.nix
            ./os/env/users/gen.nix
            ./os/env/traits/base.nix
            ./os/env/traits/has/sound.nix
            ./os/env/traits/has/terminal.nix
            ./os/env/traits/has/suid.nix
            ./os/env/traits/has/gui.nix
            ./os/env/traits/has/games.nix
            ./os/env/traits/is/bootable.nix
            ./os/env/traits/is/networked.nix
            ./os/env/traits/is/amdgpu.nix
            ./os/env/apps/office.nix
            # TODO Add freyqf to system set
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.gen = { config, pkgs, ... }: {
                  imports = [
                    ./os/home.nix
                    ./os/apps/git.nix
                    ./os/apps/vscode.nix
                    ./os/apps/tweaks.nix
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
