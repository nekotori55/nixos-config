{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) bool path string;
in
{
  options.modules.home = {
    desktop = {
      wallpapers = {
        autoFetch = mkOption {
          type = bool;
          description = "Whether to automatically fetch wallpapers";
        };
        location = mkOption {
          type = path;
          description = "Where should fetched wallpapers be stored";
          default = "/home/${config.modules.meta.username}/.cache/wallpapers";
        };
        # source = mkOption {
        #   type = string;
        #   description = "Where to get wallpapers from";
        # };
      };
    };
  };
}
