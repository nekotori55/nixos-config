{ lib, config, ... }:
with lib;
{
  imports = [
    ./bspwm.nix
  ];

  options = {
    modules.desktop = {
      # TODO check if works
      enable = mkEnableOption {
        default = config.desktop.wm == "";
      };

      wm = mkOption {
        type = enum [
          "none"
          "bspwm"
        ];
        default = "none";
        description = "which desktop to use";
      };
    };
  };
}
