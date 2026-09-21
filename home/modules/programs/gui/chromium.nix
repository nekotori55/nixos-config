{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.programs.gui.chromium;
in
{
  options.modules.programs.gui.chromium.enable = mkEnableOption "enable chromium";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ungoogled-chromium ];
  };
}
