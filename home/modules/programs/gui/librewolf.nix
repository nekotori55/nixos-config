{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.programs.gui.librewolf;
in
{
  options.modules.programs.gui.librewolf.enable = mkEnableOption "enable librewolf";

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
    };
  };
}
