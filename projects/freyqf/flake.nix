{
  description = "Personal Dwarf Fortress quickfort scripts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
    {
      systems = [ "x86_64-linux" ];
      perSystem = { config, ... }:
      {
        home.users.gen.packages = {
          freyqf = pkgs.lib.mkDerivation {
            name = "freyqf";
            description = "Personal Dwarf Fortress quickfort scripts";
            src = ./src;
            phases = [ "installPhase" ];

            installPhase = ''
              mkdir -p $out
              cp -r $src/**/* $out
            '';
          };
        };
      };
    }
  };
}
