{ lib, ... }:
with lib;
with types;
{
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "";
    hostConfig = mkOption {
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
