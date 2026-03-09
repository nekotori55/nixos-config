{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkOption mkEnableOption;
  inherit (lib.types) path;

  cfg = config.modules.antiblock.throne;
in
{
  options.modules.antiblock.throne = {
    enable = mkEnableOption "enable throne program";
    keyFile = mkOption {
      type = path;
      description = "Path of file with keys";
    };
  };

  config = mkIf cfg.enable {
    programs.throne = {
      enable = true;
      tunMode.enable = true;
    };
  };
}
