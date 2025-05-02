{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  modules = {
    home.useHomeManager = true;
    desktop = {
      wm = "hyprland";
      hyprland = {
        hostConfig = ''
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
        '';
        mutableConfigFile.enable = true;
      };
    };

    home.apps = {
      browsers.librewolf.enable = true;
    };

  };

  networking.networkmanager.enable = true;
  #powersaveable

  environment.systemPackages = with pkgs; [
    vscode-fhs
    zed-editor
  ];

  nixpkgs.config.allowUnfree = true;

  # add on first install
  system.stateVersion = "23.05";
}
