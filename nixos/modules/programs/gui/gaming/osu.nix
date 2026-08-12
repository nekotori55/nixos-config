{ lib, config, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption;
in
{
    options.modules.programs.gui.gaming.osu = {
      enable = mkEnableOption "osu! Click the circles!";
    };

    config = mkIf config.modules.programs.gui.gaming.osu.enable {
      environment.systemPackages = [
        pkgs.osu-lazer-bin
      ];
    };
}