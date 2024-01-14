{ environment, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wayfire
    swaylock
    swayidle
    grim
    wl-clipboard

    foot
    wofi
    wdisplays

    gnome3.adwaita-icon-theme

    dbus
    glib
    xdg-utils
  ];

  services = {
    dbus.enable = true;
    greetd = {
      enable = false;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd wayfire";
	  user = "gen";
	};
      };
    };
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
	gnome.enable = true;
      };
      displayManager = {
        gdm.enable = true;
      };
    };
  };


  # Prevent greetd from spamming dmesg
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };


  security.pam = { 
    services.swaylock = {};
    loginLimits = [
      { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    ];
  };

}
