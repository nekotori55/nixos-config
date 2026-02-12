{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.packettracer;
in
{
  options.modules.packettracer.enable = mkEnableOption "Install Cisco Packettracer (requires download)";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ciscoPacketTracer9 ];
  };
}
