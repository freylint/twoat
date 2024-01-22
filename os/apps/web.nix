{ config, pkgs, inputs, ... }: let 
  inherit (inputs) nixpkgs home-manager;
  inherit (config) allowUnfree;
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
            "browser.startup.homepage" = "about:blank";
          };
        };
      };
    };
  };
}
