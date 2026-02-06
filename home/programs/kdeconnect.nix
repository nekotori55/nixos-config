{ lib, osConfig, ... }:
let
  inherit (lib) mkIf;
in
{
  services.kdeconnect = mkIf osConfig.modules.kdeconnect.enable {
    enable = true;
    indicator = true;
  };
}
