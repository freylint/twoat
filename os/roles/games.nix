{ environment, pkgs, ... }:
{
  imports = [
    ../components/gui.nix
    ../components/tweaks.nix
  ];

  environment.systemPackages = with pkgs; [
    heroic
    lutris
    wineWowPackages.waylandFull
    winetricks
    wineasio
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
