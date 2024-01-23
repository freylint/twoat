{ services, inputs, ... }: {
  services.zabbixServer = {
    enable = true;
    openFirewall = true;
  };
  services.zabbixWeb = {
    enable = true;
    virtualHost = {
      hostName = "zabbix.localhost";
      adminAddr = "webmaster@localhost";
    };
  };
}
