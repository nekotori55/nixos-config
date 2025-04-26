{ lib, config, ... }:
with lib;
with types;
let
  cfg = config.modules.home;
in
{
  options = {
    modules.home = {
      user = mkOption {
        type = attrs;
        default = {
          name = "nekotori55";
        };
      };

      dir = mkOption {
        type = str;
        default = "${cfg.user.home}";
      };

      binDir = mkOption {
        type = str;
        default = "${cfg.dir}/.local/bin";
      };

      cacheDir = mkOption {
        type = str;
        default = "${cfg.dir}/.cache";
      };

      configDir = mkOption {
        type = str;
        default = "${cfg.dir}/.config";
      };

      dataDir = mkOption {
        type = str;
        default = "${cfg.dir}/.local/share";
      };

      stateDir = mkOption {
        type = str;
        default = "${cfg.dir}/.local/state";
      };

      fakeDir = mkOption {
        type = str;
        default = "${cfg.dir}/.local/user";
      };

      xdg = {
        enable = mkOption {
          type = bool;
          default = true;
        };
      };

      useHomeManager = mkEnableOption "Use home manager";
    };
  };
}
