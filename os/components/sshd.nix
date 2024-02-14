{ config, services, ... } : {
  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };

  networking.firewall.allowTCPPorts = [ 22 ];
}
