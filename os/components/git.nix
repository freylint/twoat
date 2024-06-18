{ programs, config, ... }:
{
  home-manager.users.gen = {
    programs = {
      git = {
        enable = true;
        userName = "lmpriestley";
        userEmail = "lucas@freyground.com";
        signing = {
          key = "28F37DF3674BF7D0";
          signByDefault = true;
        };
      };
    };
  };
}
