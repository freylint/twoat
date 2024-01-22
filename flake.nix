{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
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
          })
          inputs.sops-nix.nixosModules.sops
          ./os/machine/gdw.nix
          ./os/roles/base.nix
          ./os/roles/dev.nix
          ./os/roles/games.nix
          ./os/components/bootable.nix
          ./os/components/networked.nix
          ./os/components/amdgpu.nix
          ./os/components/sound.nix
          ./os/components/gui.nix
          ./os/components/office.nix
          ./os/components/tweaks.nix
          ./os/components/web.nix
          ./os/components/zabbix.nix
        ];
      };
    };
  };
}
