{
  description = "Personal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let 
      inherit (self) outputs;
      tlib = import ./os/lib/traitlib.nix { inherit home-manager; };
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
            (tlib.hMantoOs "./apps/git.nix")
            (tlib.hMantoOs "./apps/tweaks.nix")
            (tlib.hMantoOs "./apps/vscode.nix")
          ];
        };
      };
    };
}
