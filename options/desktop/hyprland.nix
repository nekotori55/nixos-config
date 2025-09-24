{ lib, ... }:
with lib;
with types;
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "";
    additionalConfig = mkOption {
      type = lines;
      default = "";
    };
    mutableConfigFile = {
      enable = mkEnableOption "";
      path = mkOption {
        type = string;
        default = "$XDG_CONFIG_HOME/hypr/hyprland.mutable.conf";
      };
    };
  };
}
