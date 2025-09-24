{ lib, config, ... }:
with lib;
with types;
{
  imports = [
    ./bspwm.nix
    ./hyprland.nix
    ./kde.nix
  ];

  options = {
    modules.desktop = {
      wm = mkOption {
        type = enum [
          "none"
          "bspwm"
          "hyprland"
          "kde"
        ];
        default = "none";
        description = "which desktop to use";
      };
      backend = mkOption {
        type = enum [
          "none"
          "x11"
          "wayland"
        ];
      };
      theme = mkOption {
        type = enum [
          "default"
          "windows"
          "dynamic"
        ];
        default = "default";
        description = "which theme to use";
      };
    };
  };

  config = {
    modules.desktop.bspwm.enable = mkDefault (config.modules.desktop.wm == "bspwm");
    modules.desktop.hyprland.enable = mkDefault (config.modules.desktop.wm == "hyprland");
    modules.desktop.kde.enable = mkDefault (config.modules.desktop.wm == "kde");

    modules.desktop.backend = mkDefault "none";
  };
}
