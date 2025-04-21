{ lib, config, ... }:
with lib;
with types;
let
  cfg = config.home;
in
{
  options = {
    modules.home = {
      dir = mkOption {
        type = str;
        default = "${config.user.home}";
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
    };
  };
}
