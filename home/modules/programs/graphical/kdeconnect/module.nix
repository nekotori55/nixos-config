{
  lib,
  osConfig,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  headless = osConfig.modules.meta.headless;
  enabledOnHost = osConfig.modules.misc.kdeconnect.enable;
in
{
  config = lib.mkIf config.modules.graphics.enabled {
    services.kdeconnect = mkIf (enabledOnHost && (!headless)) {
      enable = true;
      indicator = true;
    };
  };
}
