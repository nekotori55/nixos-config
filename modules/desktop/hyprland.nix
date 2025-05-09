{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    modules.desktop.backend = "wayland";

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "nekotori55";

    programs.hyprland.enable = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      TOPBAR = "waybar";
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      waybar # TODO replace with EWW
      brightnessctl
    ];

    fonts.packages = with pkgs; [
      font-awesome # needed for waybar # TODO check if can put in home manager
    ];

    virtualisation.vmVariant = {
      virtualisation.qemu.options = [
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
        # "-audio pa,model=hda"
      ];

      environment.sessionVariables = {
        # WLR_NO_HARDWARE_CURSORS = "1";
      };

      modules.desktop.hyprland.hostConfig = mkForce ''
        animations {
          enabled = false
        }

        cursor {
          no_hardware_cursors = true
        }
      '';
    };
  };
}
