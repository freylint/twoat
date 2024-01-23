{ services, inputs, ... }: {
  services.zabbixAgent = {
    enable = true;
    server = "localhost";
  };
}
