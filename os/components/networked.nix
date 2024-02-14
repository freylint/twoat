{ networking, ... }: let
  # TODO make IP static through nix managed router
  hosts = {
    gdw = "192.168.1.124";
    ghl = "192.168.1.190";
  };
in {
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    hosts = {
      "gdw" = [ hosts.gdw ];
      "zabbix" = [ hosts.ghl ];
    };
  };
}
