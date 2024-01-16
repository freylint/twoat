{ programs, config, ... }:
{
  programs = {
    freyqf = {
      enable = true;
      symlink = true;
      destination = ".local/share/Steam/steamapps/common/Dwarf Fortress/dfhack-config/blueprints/";
    };
  };
}