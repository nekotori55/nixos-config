{ lib, config, ... }:
let
  inherit (lib) mkDefault mkIf;
in
{
  config = mkIf (config.modules.profiles.profile == "workstation") {
    modules = {
      home.enableHomeManager = mkDefault true;
      misc.kdeconnect.enable = mkDefault true;
      secrets.installAgenixCli = mkDefault true;
    };
  };
}
