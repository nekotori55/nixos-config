{ lib, config, ... }:
let
  inherit (lib) mkIf;
  default-specialisation = config.specialisation != { };
in
{
  modules = {
    gaming = {
      enable = true;
      steam = true;
      minecraft = true;
      gamescope = true;
      osu = true;
    };
    antiblock.throne.enable = true;
    virtualisation.waydroid.enable = true;
    peripherals.logitech.enable = true;
    distributed-builds.enable = true;

    desktop.wm.niri.host-specific-config = mkIf default-specialisation ''
      debug {
          render-drm-device "/dev/dri/by-path/pci-0000:01:00.0-card"
      }

      environment {
          NVD_BACKEND "direct"
          LIBVA_DRIVER_NAME "nvidia"
          __GLX_VENDOR_LIBRARY_NAME "nvidia"
      }
    '';
  };
}
