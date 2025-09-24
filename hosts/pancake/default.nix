{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    ../green/zapret.nix # TODO
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  modules = {
    home.useHomeManager = true;
    desktop = {
      wm = "hyprland";
      hyprland = {
        mutableConfigFile.enable = true;
        additionalConfig = ''
          # TODO media keys binds
          monitor = eDP-1, 1920x1080@60, 1920x0, 1

          $LAPTOP_KB_ENABLED = true
          device {
            name = at-translated-set-2-keyboard
            enabled = $LAPTOP_KB_ENABLED
          }

        '';
      };
    };

    home.apps = {
      browsers.librewolf.enable = true;
    };
  };

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    zed-editor # does it even work lol
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Istanbul";

  # add on first install
  system.stateVersion = "23.05";
}
