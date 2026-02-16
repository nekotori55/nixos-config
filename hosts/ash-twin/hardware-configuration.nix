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
      device = "/var/lib/swapfile";
      size = 20 * 1024;
    }
  ];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;

    # settings = {
    # General = {
    # Enable = "Source,Sink,Media,Socket";
    # };
    # };
  };

  boot.extraModprobeConfig = ''
    options btusb autosuspend=0
  '';

  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      # extraConfig = ''
      # terminal_input console
      # terminal_output console
      # '';
      gfxmodeEfi = "1920x1080";
    };
    # systemd-boot = {
    #   enable = true;
    #   # consoleMode = "max";
    #   configurationLimit = 10;
    # };

    efi.canTouchEfiVariables = true;
  };

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

}
