
# Creates a single node k3s instance for deploying to kubernetes

{ config, networking, services, environment, ... }: {
  environment.systemPackages = with pkgs; [ k3s ];
  services.k3s = {
    enable = true;
    role = "server";
  };
  networking.firewall = {
    allowedTCPPorts = [ 6443 ];
  };
}
