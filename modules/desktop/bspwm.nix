{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with types;
let
  cfg = config.modules.desktop.bspwm;
in
{
  config = mkIf cfg.enable {
    modules.desktop.backend = "x11";

    services.xserver = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
      };
    };

    environment.systemPackages = cfg.additionalPackages;
  };
}
