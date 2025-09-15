{ lib, ... }:
{
  imports = [
    ./nvidia.nix
  ];

  # BOOTLOADER
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      default = "saved";
    };
    # systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 20 * 1024;
    }
  ];

  networking.hostName = "green";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = lib.mkDefault true;
  };
  services.blueman.enable = true;

  specialisation = {
    on-the-go.configuration = {
      hardware.bluetooth.powerOnBoot = false;

      powerManagement.scsiLinkPolicy = "medium_power";
      powerManagement.cpuFreqGovernor = "powersave";
      powerManagement.enable = true;
      powerManagement.powertop.enable = true;

    };
  };
}
