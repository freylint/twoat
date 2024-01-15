# A set of tweaks to nixos aimed to have a system which is more pleasing to my tastes.

{ environment, pkgs, ... }:
{
  # Remove unused applications from gnome
  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany     # web browser
    gedit     # text editor
    totem     # video player
    yelp     # help viewer
    geary     # email client
    gnome-calendar     # calendar
    gnome-contacts     # contacts
    gnome-maps      # maps
    gnome-music     # music
    pkgs.gnome-photos     # photos
    pkgs.gnome-tour     # tour app
    evince     # document viewer
  ]; 
}