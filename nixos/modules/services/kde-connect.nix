{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.modules.services.kde-connect = {
    enable = mkEnableOption "kde connect";
  };

  config = mkIf config.modules.services.kde-connect.enable {
    programs.kdeconnect.enable = true;

    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
