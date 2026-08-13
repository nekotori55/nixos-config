{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib) mapAttrsToList;
  inherit (lib.types) listOf str bool;

  cfg = config.modules.services.fail2ban;

in
{
  options.modules.services.fail2ban = {
    enable = mkEnableOption "fail2ban, service to auto ban probing bots";
  };

  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      bantime-increment.enable = true;
    };
  };
}
