{ config, lib, ... }:
let
  cfg = config.modules.kdeconnect;
in
{
  options.modules.kdeconnect = {
    enable = lib.mkEnableOption "Enable KDE Connect and open firewall ports";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };

    programs.kdeconnect.enable = true;

  };
}
