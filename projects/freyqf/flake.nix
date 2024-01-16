{
  description = "FreyQF Quickfort Library";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/23.11;
    home-manager.url = github:nix-community/home-manager;
  };

  outputs = { self, nixpkgs, home-manager }: {
    homeConfigurations."freyqf" = {
      packages = [
        {
          pname = "freyqf";
          version = "1.0";
          src = ./.;
          nativeBuildInputs = [ nixpkgs.nix ];
          installPhase = ''
            dest="${HOME}/.local/share/Steam/steamapps/common/Dwarf\ Fortress"
            mkdir -p $dest/
            cp -r $src/* $dest/
          '';
          meta = with nixpkgs.lib; {
            description = "FreyQF Quickfort library";
            license = licenses.mit;
          };
        }
      ];
    };

    defaultPackage = self.homeConfigurations."freyqf";
  };
}
