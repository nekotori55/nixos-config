{ ... }:
{
  # Filesystems
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
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
      device = "/var/lib/swapfile";
      size = 20 * 1024;
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
      useOSProber = true;
      default = "saved";
    };
    efi.canTouchEfiVariables = true;
  };

  # Firmware
  hardware.enableRedistributableFirmware = true;
}
