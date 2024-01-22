{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      gdw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs home-manager; };
        modules = [
          ({
            networking.hostName = "gdw";
            time.timeZone = "America/New_York";
          })
          ./os/env/base.nix
          ./os/machine/gdw.nix
          ./os/machine/bootable.nix
          ./os/machine/networked.nix
          ./os/machine/amdgpu.nix
          ./os/env/sound.nix
          ./os/env/suid.nix
          ./os/env/gui.nix
          ./os/env/games.nix
          ./os/env/virt.nix
          ./os/apps/office.nix
          ./os/apps/git.nix
          ./os/apps/tweaks.nix
          ./os/apps/vscode.nix
          ./os/apps/web.nix
        ];
      };
    };
  };
}
