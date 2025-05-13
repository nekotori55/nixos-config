{ pkgs, config, lib, ... }:
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
        mutableConfigFile.enable = true;
        hostConfig = ''
        cursor {
          no_hardware_cursors = true
        }

        animations {
          enabled = false
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
    zed-editor
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Istanbul";

  # add on first install
  system.stateVersion = "23.05";
}
