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
  in {
    nixosConfigurations = {
      "gdw" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	      specialArgs = {inherit inputs outputs;};
        modules = [
          ./machine/gdw.nix
	        ./env/configuration.nix
          ./env/users/gen.nix
          ./env/traits/base.nix
          ./env/traits/has-sound.nix
          ./env/traits/has-console.nix
          ./env/traits/bootable.nix
          ./env/traits/networked.nix
          ./env/traits/editable.nix
          ./env/traits/needs-suid.nix
          ./env/traits/has-gui.nix
          ./env/traits/has-gaming.nix
          ./env/traits/amdgpu.nix
          ./apps/office.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.gen = {config, pkgs, ...}:{
                imports = [
                  ./env/home.nix
                  ./apps/git.nix
                  ./apps/vscode.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
