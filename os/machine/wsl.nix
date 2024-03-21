{ ... }:
{
  disko.devices = {
    disk.disk1 = {
      device = "/dev/sdg";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          wslg = {
            start = "1MiB";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/dev/sdg[/mnt/wslg/distro]";
            };
          };
          nix-store = {
            name = "nix-store";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/dev/sdg[/nix/store]";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
