{ ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [
        "uid=0"
        "gid=0"
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  # Swap
  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];
}
