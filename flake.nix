{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    sops-nix.url = "github:Mic92/sops-nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = github:nix-community/nixos-wsl;
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let 
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
          ./os/components/gpu-nvidia.nix
          ./os/components/zabbix-agent.nix
      ];

      gws = [
        ./os/machine/gws.nix
        ./os/machine/efi.nix
      ];

      # General purpose home lab server
      ghl = [
        ({
          networking.hostName = "ghl";
          time.timeZone = "America/New_York";
        })
        ./os/machine/ghl.nix
        ./os/machine/efi.nix
        ./os/roles/base.nix
        ./os/components/sshd.nix
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

      gws = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = hostModules.gws;
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
