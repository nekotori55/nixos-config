{ lib, config, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption;
in
{
    options.modules.programs.gui.gaming.gamescope = {
      enable = mkEnableOption "gamescope, valve simplistic compositor";
    };

    config = mkIf config.modules.programs.gui.gaming.gamescope.enable {
      programs.gamescope =  {
        enable = true;
        # capSysNice = true;
        args = [
          # "--rt"
          "-w 1920 -h 1080"
          "-W 1920 -H 1080"
          "-r 144"
          "-S integer"
          # "--prefer-vk-device 10de:1f91"
          "-F nearest"
          "--sharpness 0"
          "-f"
        ];
      };
    };
}