{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.desktop.bspwm;
in
{
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      windowManager.bspwm = {
        enable = true;
        configFile = mkIf (!config.users.useHomeManager) cfg.configFilePath;
        sxhkd.configFile = mkIf (!config.users.useHomeManager) cfg.sxhkd.configFilePath;
      };
    };

    environment.systemPackages = [ ] ++ cfg.additionalPackages;
  };
}
