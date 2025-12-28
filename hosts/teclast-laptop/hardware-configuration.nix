{ ... }:
{
  # Filesystems
  fileSystems = {
    "/" = {
      # device = "/dev/disk/by-label/nixos";
      device = "/dev/disk/by-uuid/0e776749-b0ac-4201-8869-d1a8cdc802bd";
      fsType = "ext4";
    };

    "/boot" = {
      # device = "/dev/disk/by-label/boot";
      device = "/dev/disk/by-uuid/6462-890A";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  # Swap
  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
  };

  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # useOSProber = true;
      default = "saved";
    };
    efi.canTouchEfiVariables = true;
  };
}
