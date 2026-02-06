{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.kdeconnect;
in
{
  options.modules.kdeconnect = {
    enable = mkEnableOption "Enable KDE Connect and open firewall ports";
  };

  config = mkIf cfg.enable {
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
