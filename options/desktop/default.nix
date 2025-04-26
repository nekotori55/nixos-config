{ lib, config, ... }:
with lib;
with types;
{
  imports = [
    ./bspwm.nix
  ];

  options = {
    modules.desktop = {
      wm = mkOption {
        type = enum [
          "none"
          "bspwm"
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
    };
  };

  config = {
    modules.desktop.bspwm.enable = (config.modules.desktop.wm == "bspwm");
  };
}
