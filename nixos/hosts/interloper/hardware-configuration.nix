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

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
  };
  services.blueman.enable = true;

  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # default = "saved";
    };
    efi.canTouchEfiVariables = true;
  };

  hardware.enableRedistributableFirmware = true;
}
