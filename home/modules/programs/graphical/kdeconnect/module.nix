{
  lib,
  osConfig,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  # headless = osConfig.modules.meta.headless;
  enabledOnHost = osConfig.modules.misc.kdeconnect.enable;
in
{
  config = mkIf enabledOnHost {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
