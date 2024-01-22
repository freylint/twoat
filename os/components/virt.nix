{ virtualization, inputs, ... }: let
  inherit (inputs) home-manager;
in {
  virtualisation.libvirtd.enable = true;
  # TODO make GUI optional
  programs.virt-manager.enable = true;
  home-manager.users.gen = {
    dconf = {
      enable = true;
      settings."org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
