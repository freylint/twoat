# A set of tweaks to nixos aimed to have a system which is more pleasing to my tastes.

{ environment, pkgs, config, home-manager, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  home-manager.users.gen = {
    home.packages = with pkgs; [ dconf ];
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk3";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    #systemd.user.sessionVariables = config.home-manager.users.gen.home.sessionVariables;
  };

}
