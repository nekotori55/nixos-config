{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.antiblock.zapret;
in
{
  options.modules.antiblock.zapret.enable = mkEnableOption "Enable zapret";

  config = mkIf cfg.enable {
    services.zapret-discord-youtube = {
      enable = true;
      configName = "general(ALT7)";
    };
  };
}
