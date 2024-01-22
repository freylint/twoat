{ config, pkgs, inputs, ... }: let 
  inherit (inputs) nixpkgs home-manager nur;
  inherit (config) allowUnfree;
  firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
in 
{
  home-manager.users.gen = {
    home.packages = with pkgs; [
      firefox
    ];

    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          settings = {
            "browser.startup.homepage" = "­about:newtab";
          };
          extensions = with firefox-addons; [
            ublock-origin
            bitwarden
          ];
        };
      };
    };
  };
}
