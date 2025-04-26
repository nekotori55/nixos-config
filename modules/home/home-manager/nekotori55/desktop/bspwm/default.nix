{
  osConfig,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = osConfig.modules.desktop.bspwm;
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
      "bspwm/bspwmrc" = {
        source = ./config/bspwmrc;
        # recursive = true;
      };

      "sxhkd/sxhkdrc" = {
        source = ./config/sxhkdrc;
        # recursive = true;
      };
    };

  };
}
