{ lib, config, ... }:
let
  inherit (lib) mkIf;
  is-default-specialisation = config.specialisation != { };
in
{
  modules = {
    gaming = {
      enable = true;
      steam = true;
      minecraft = true;
      gamescope = true;
    };
    antiblock.throne.enable = true;
    peripherals.logitech.enable = true;

    desktop.wm.plasma.enable = true;
    desktop.wm.niri.host-specific-config = mkIf is-default-specialisation ''
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
