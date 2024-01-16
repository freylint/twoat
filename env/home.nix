{ config, pkgs, ... }: {
  programs = {
    home-manager.enable = true;
    foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          term = "xterm-256color";
          font = "Fira Code:size=11";
          dpi-aware = "yes";
        };
        mouse = { hide-when-typing = "yes"; };
      };
    };
  };

  home = {
    username = "gen";
    homeDirectory = "/home/gen";
    stateVersion = "23.11";
    packages = with pkgs; [ fira-code neovim firefox ];
  };
}
