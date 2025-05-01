{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      TOPBAR = "waybar";
    };
    environment.systemPackages = with pkgs; [
      hyprpaper
      waybar # TODO replace with EWW
    ];

    virtualisation.vmVariant = {
        virtualisation = {
          # sharedDirectories = {
          #   home = {
          #     source = "$HOME";
          #     target = "/mnt";
          #   };
          # };
        };

        virtualisation.qemu.options = [
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
          "-audio pa,model=hda"
        ];

        environment.sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";
        };
      };
  };
}
