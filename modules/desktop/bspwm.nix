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
  options = {
    modules.desktop.bspwm = {
      enable = mkEnableOption {
        default = config.desktop.wm == "bspwm";
      };

      configFilePath = mkOption {
        type = path;
        default = configPath + "/desktop/bspwm/bspwmrc";
      };

      sxhkd = {
        configFilePath = mkOption {
          type = path;
          default = configPath + "/desktop/bspwm/sxhkdrc";
        };
      };

      # TODO maybe put it into separate option
      picom = {
        configFilePath = mkOption {
          type = path;
          default = configPath + "/desktop/bspwm/picom";
        };
      };

      additionalPackages = mkOption {
        type = listOf package;
        default = [ ];
        example = [ pkgs.kitty ];
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      windowManager.bspwm = {
        enable = true;
        configFile = mkIf (!config.modules.homeManager.enable) cfg.configFilePath;
        sxhkd.configFile = mkIf (!config.modules.homeManager.enable) cfg.sxhkd.configFilePath;
      };
    };

    environment.systemPackages =
      with pkgs;
      [
        kitty
      ]
      ++ cfg.additionalPackages;
  };
}
