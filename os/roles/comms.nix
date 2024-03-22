{ pkgs, inputs, ... }: let 
  inherit (inputs) home-manager;
in {
  environment.systemPackages = with pkgs; [
    discord-ptb
  ];

  # TODO Upstream as option to home-manager?
  home-manager.users.gen.home = {
    file."settings.json" = {
      target = ".config/discord/settings.json";
      text = ''
        {
          "SKIP_HOST_UPDATE": true
        }
      '';
    };
  };
}
