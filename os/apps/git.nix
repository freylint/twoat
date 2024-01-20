{ programs, config, ... }:
{
  home-manager.users.gen = {
    programs = {
      git = {
        enable = true;
        userName = "Lucas Priestley";
        userEmail = "lmpriestley@outlook.com";
      };
    };
  };
}