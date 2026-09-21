{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption optional;
  cfg = config.modules.programs.gui.utils;
in
{
  options.modules.programs.gui.utils = {
    enable = mkEnableOption "Utils";
    kcalc.enable = mkEnableOption "KDE calculator";
    ghostwriter.enable = mkEnableOption "Kde md editor"; 
  };

  config = lib.mkIf cfg.enable {
    home.packages = []
    ++ optional cfg.kcalc.enable pkgs.kdePackages.kcalc
    ++ optional cfg.ghostwriter.enable pkgs.kdePackages.ghostwriter
    ;
  };
}
