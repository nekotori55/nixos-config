{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.programs.firefox;
in
{
  options.modules.programs.firefox.enable = mkEnableOption "enable Firefox";

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
    };
  };
}
