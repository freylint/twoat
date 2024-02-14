{ services, inputs, ... }: {
  services.zabbixServer = {
    enable = true;
    openFirewall = true;
  };
  services.zabbixWeb = {
    enable = true;
    virtualHost = {
      hostName = "ghl";
      adminAddr = "lmpriestley@outlook.com";
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 ];
}
