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
            ./machine/gdw.nix
            ./env/configuration.nix
            ./env/users/gen.nix
            ./env/traits/base.nix
            ./env/traits/has/sound.nix
            ./env/traits/has/terminal.nix
            ./env/traits/has/suid.nix
            ./env/traits/has/gui.nix
            ./env/traits/has/games.nix
            ./env/traits/is/bootable.nix
            ./env/traits/is/networked.nix
            ./env/traits/is/amdgpu.nix
            ./env/apps/office.nix
            # TODO Add freyqf to system set
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.gen = { config, pkgs, ... }: {
                  imports = [
                    ./env/home.nix
                    ./env/apps/git.nix
                    ./env/apps/vscode.nix
                    ./env/apps/tweaks.nix
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
