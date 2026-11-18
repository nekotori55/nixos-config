{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types)
    listOf
    str
    package
    ;

  cfg = config.modules.services.plymouth;

in
{
  options.modules.services.plymouth = {
    enable = mkEnableOption "plymouth, boot animation";
    theme = mkOption {
      type = str;
    };
    themePackages = mkOption {
      type = listOf package;
    };
  };

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      theme = cfg.theme;
      themePackages = cfg.themePackages;
    };
  };
}
