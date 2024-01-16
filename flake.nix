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
            ./os/users/gen.nix
            ./os/env/base.nix
            ./os/env/has/sound.nix
            ./os/env/has/terminal.nix
            ./os/env/has/suid.nix
            ./os/env/has/gui.nix
            ./os/env/has/games.nix
            ./os/env/is/bootable.nix
            ./os/env/is/networked.nix
            ./os/env/is/amdgpu.nix
            ./os/apps/office.nix
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
