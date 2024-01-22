{ programs, config, nur, ... }:
{
  home-manager.users.gen = {
    programs = {
      firefox = {
        enable = true;
        profiles.default = {
          id = 0;
          name = "general";
          isDefault = true;
          bookmarks = { };
          extensions = with nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
          ];
        };
      };
    };
  };
}
