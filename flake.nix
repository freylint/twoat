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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-generators, ... }: let 
    hostModules = {
      # General purpose desktop workstation
      gdw = [
          ({
            networking.hostName = "gdw";
            time.timeZone = "America/New_York";
          })
          ./os/machine/gdw.nix
          ./os/machine/efi.nix
          ./os/roles/base.nix
          ./os/roles/desktop.nix
          ./os/roles/dev.nix
          ./os/roles/games.nix
          ./os/roles/comms.nix
          ./os/components/amdgpu.nix
          ./os/components/zabbix-agent.nix
      ];

      # General purpose home lab server
      ghl = [
        ({
          networking.hostName = "ghl";
          time.timeZone = "America/New_York";
        })
        ./os/roles/base.nix
        ./os/components/zabbix-srv.nix
        ./os/components/zabbix-agent.nix
      ];
    };
  in {

    nixosConfigurations = {
      gdw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = hostModules.gdw;
      };
      # TODO get nix-disco working
      # FIXME Has no hardware configuration
      # FIXME Uses local gen user
      ghl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = hostModules.ghl;
      };
    };
  };
}
