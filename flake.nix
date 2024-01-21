{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs-channels/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, unstable, home-manager, ... }: {
    nixosConfigurations = {
      gdw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs home-manager; };
        modules = [
          ./os/env/base.nix
          ./os/machine/gdw.nix
          ./os/machine/bootable.nix
          ./os/machine/networked.nix
          ./os/machine/amdgpu.nix
          ./os/env/sound.nix
          ./os/env/suid.nix
          ./os/env/gui.nix
          ./os/env/games.nix
          ./os/apps/office.nix
          ./os/apps/git.nix
          ./os/apps/tweaks.nix
          ./os/apps/vscode.nix
          ({ config, pkgs, ... }: {
            environment.systemPackages = [
              unstable.legacyPackages."x86_64-linux".hello
            ];
          })
        ];
      };
    };
  };
}