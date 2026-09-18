{ config, lib, pkgs, ... }:
let
  cfg = config.modules.programs.gui.fun;
in
{
  options.modules.programs.gui.fun = {
    kteatime = lib.mkEnableOption "tea time tracker";
  };

  config = {
    home.packages = []
    ++ lib.optional cfg.kteatime pkgs.kdePackages.kteatime;
  };
}
