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

  # SOUND
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # wireplumber.extraConfig = {
    #   "override.monitor.bluez.properties" = {
    #     "bluez5.enable-msbc" = false;
    #     "bluez5.hfphsp-backend" = "none";
    #     "bluez5.a2dp.ldac.quality" = "mq";
    #     "api.alsa.headroom" = 1024;
    #     "bluez5.a2dp.aac.bitratemode" = 1;
    #     "bluez5.roles" = [
    #       "a2dp_sink"
    #       "a2dp_source"
    #     ];
    #     "10-disable-camera" = {
    #       "wireplumber.profiles" = {
    #         main."monitor.libcamera" = "disabled";
    #       };
    #     };
    #   };
    # };

  };

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.hfphsp-backend" = "none";
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "a2dp_sink"
        "a2dp_source"
      ];
      "10-disable-camera" = {
        "wireplumber.profiles" = {
          main."monitor.libcamera" = "disabled";
        };
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = lib.mkDefault true;
    hsphfpd.enable = false;
  };
  services.blueman.enable = true;

  specialisation = {
    on-the-go.configuration = {
      hardware.bluetooth.powerOnBoot = false;

      # powerManagement.scsiLinkPolicy = "medium_power";
      powerManagement.cpuFreqGovernor = "powersave";
      powerManagement.enable = true;
      powerManagement.powertop.enable = true;

      services.tlp = {
        enable = true;
      };

    };
  };
}
