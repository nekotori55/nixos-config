{ config, lib, pkgs, ... }:
let
  cfg = config.modules.programs.gui.editors;
in
{
  options.modules.programs.gui.editors = {
    enable = lib.mkEnableOption "Various editors";

    blockbench.enable = lib.mkEnableOption "Simple editor for low-poly modles";
    libreoffice.enable = lib.mkEnableOption "Libreoffice";
    krita.enable = lib.mkEnableOption "Krita";
    obsidian.enable = lib.mkEnableOption "Obsidian";
  };

  config = lib.mkIf config.modules.programs.gui.editors.enable {
    home.packages = []
    ++ (lib.optional cfg.blockbench.enable pkgs.blockbench)
    ++ (lib.optional cfg.libreoffice.enable pkgs.libreoffice)
    ++ (lib.optional cfg.krita.enable pkgs.krita)
    ++ (lib.optional cfg.obsidian.enable pkgs.obsidian)
    ;
  };
}
