{ lib, osConfig, ... }:
let
  inherit (lib) mkIf;
  headless = osConfig.modules.meta.headless;
  enabledOnHost = osConfig.modules.misc.kdeconnect.enable;
in
{
  services.kdeconnect = mkIf (enabledOnHost && (!headless)) {
    enable = true;
    indicator = true;
  };
}
