{ config, ... }:{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    # TODO support multiple users
    age.keyFile = "/home/gen/.config/sops/age/keys.txt";
  };

  sops.secrets."users/gen" = {};
}
