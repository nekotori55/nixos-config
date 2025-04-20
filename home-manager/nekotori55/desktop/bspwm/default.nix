{ osConfig, lib, ... }:
with lib;
{
  config = mkIf osConfig.desktop.bspwm.enable {
    xsession.windowManager = {
      bspwm = {
        enable = true;
      };
    };

    services.sxhkd.enable = true;
    services.picom.enable = true;

  };
}
