{ lib, ... }:
with lib;
with types;
let
  rootPath = ./. + "/..";
  configPath = rootPath + "/config";
in
{
  options = {
    users = {
      defaultUser = {
        name = mkOption {
          type = str;
          default = "user";
          description = "default user username";
        };
      };

      useHomeManager = mkOption {
        type = bool;
        default = true;
      };
    };

    home = {

      dir = mkOption
      {
        type = str;
        default = "${config.user.home}";
      } 
      binDir = mkOpt str "${cfg.dir}/.local/bin";
      cacheDir = mkOpt str "${cfg.dir}/.cache";
      configDir = mkOpt str "${cfg.dir}/.config";
      dataDir = mkOpt str "${cfg.dir}/.local/share";
      stateDir = mkOpt str "${cfg.dir}/.local/state";
      fakeDir = mkOpt str "${cfg.dir}/.local/user";
    };

    desktop = {
      # TODO check if works
      enable = mkEnableOption {
        default = config.desktop.wm == "";
      };

      wm = mkOption {
        type = enum [
          ""
          "bspwm"
        ];
        default = "";
        description = "which desktop to use";
      };

      bspwm = {
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
  };
}
