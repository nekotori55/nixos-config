{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/vda";
      content = {
        type = "gpt";
        partitions = {
          MBR = {
            type = "EF02"; # for grub MBR
            size = "1M";
            priority = 1; # Needs to be first partition
          };
          # ESP = {
          #   type = "EF00";
          #   size = "500M";
          #   content = {
          #     type = "filesystem";
          #     format = "vfat";
          #     mountpoint = "/boot";
          #     mountOptions = [ "umask=0077" ];
          #   };
          # };
          boot = {
            size = "500M";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings.allowDiscards = true; # for SSD
              # settings.fallbackToPassword  true;
              # passwordFile = "/tmp/disk.key";
              # settings.keyFile = "/tmp/disk.key";
              extraFormatArgs = [ "--pbkdf-memory 32768" ];
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}
