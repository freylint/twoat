{ programs, config, inputs, ... }: let
  addons = inputs.nur.repos.rycee.firefox-addons;
in {
  home-manager.users.gen = {
    programs = {
      firefox = {
        enable = true;
        profiles.default = {
          id = 0;
          name = "general";
          isDefault = true;
          bookmarks = { };
          extensions = with addons; [
            ublock-origin
            bitwarden
          ];
        };
      };
    };
  };
}
