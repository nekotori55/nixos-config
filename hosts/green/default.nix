{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    # TODO
    # ./zapret-custom.nix
    ./zapret.nix
  ];

  programs.nekoray = {
    enable = true;
    package = pkgs.nekoray;
    tunMode.enable = true;
    tunMode.setuid = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  modules = {
    home.useHomeManager = true;
    desktop = {
      wm = "hyprland";
      hyprland = {
        mutableConfigFile.enable = true;
      };
    };

    home.apps = {
      browsers.librewolf.enable = false;
    };
  };

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    zed-editor
    hyprpolkitagent
    prismlauncher
  ];

  security.polkit.enable = true;
  nixpkgs.config.allowUnfree = true;

  # DEFAULT SPECIALIZATION (docked)
  modules.desktop.hyprland.hostConfig = lib.mkIf (config.specialisation != { }) (''
    # DEVICE-SPECIFIC
    env = AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2

    # DEVICE-SPECIFIC
    monitor = eDP-1, 1920x1080@60, 0x0, 1
    monitor = HDMI-A-1, 1920x1080@144, 1920x0, 1

    # NVIDIA-SPECIFIC
    env = LIBVA_DRIVER_NAME,nvidia
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia

    cursor {
      no_hardware_cursors = true
    }

    workspace = 11, monitor:HDMI-A-1
    workspace = 12, monitor:HDMI-A-1
    workspace = 13, monitor:HDMI-A-1
    workspace = 14, monitor:HDMI-A-1
    workspace = 15, monitor:HDMI-A-1
    workspace = 16, monitor:HDMI-A-1
    workspace = 17, monitor:HDMI-A-1
    workspace = 18, monitor:HDMI-A-1
    workspace = 19, monitor:HDMI-A-1
    workspace = 20, monitor:HDMI-A-1

    workspace = 1, monitor:eDP-1
    workspace = 2, monitor:eDP-1
    workspace = 3, monitor:eDP-1
    workspace = 4, monitor:eDP-1
    workspace = 5, monitor:eDP-1
    workspace = 6, monitor:eDP-1
    workspace = 7, monitor:eDP-1
    workspace = 8, monitor:eDP-1
    workspace = 9, monitor:eDP-1
    workspace = 10, monitor:eDP-1

    exec-once = systemctl --user start hyprpolkitagent
  '');

  # ON THE GO SPECIALIZATION
  specialisation = {
    on-the-go.configuration = {
      environment.etc."specialisation".text = "on-the-go";

      modules.desktop.hyprland.hostConfig = (''
        monitor = eDP-1, 1920x1080@60, 0x0, 1
        env = AQ_DRM_DEVICES,/dev/dri/card2
      '');
    };
  };

  time.timeZone = "Europe/Istanbul";

  # add on first install
  system.stateVersion = "25.05";
}
