{
  osConfig,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = osConfig.modules.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    # xsession.windowManager = {
    # bspwm = {
    # enable = true;
    # };
    # };

    # services.sxhkd.enable = true;
    # services.picom.enable = true;

    xdg.configFile = {
      "hypr/" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
