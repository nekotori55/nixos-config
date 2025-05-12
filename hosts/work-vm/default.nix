{ pkgs, config, lib, ... }:
let
  commonHyprlandGreenConfig = ''
    # Laptop multimedia keys for volume and LCD brightness
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

    # Requires playerctl
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous
  '';
in
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
