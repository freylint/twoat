{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      gdw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ({
            networking.hostName = "gdw";
            time.timeZone = "America/New_York";
            system.stateVersion = "23.11";
            imports = [
              home-manager.nixosModules.home-manager
            ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.gen.home.stateVersion = "23.11";
            };
          })
          ./os/machine/gdw.nix
          ./os/machine/bootable.nix
          ./os/machine/networked.nix
          ./os/machine/amdgpu.nix
          ./os/users/gen.nix
          ./os/env/base.nix
          ./os/env/sound.nix
          ./os/env/suid.nix
          ./os/env/gui.nix
          ./os/env/games.nix
          ./os/apps/office.nix
          ./os/apps/git.nix
          ./os/apps/tweaks.nix
          ./os/apps/vscode.nix
        ];
      };
    };
  };
}