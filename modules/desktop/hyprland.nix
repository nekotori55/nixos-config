{ config, lib, ... }:
with lib;
let
  cfg = config.modules.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
