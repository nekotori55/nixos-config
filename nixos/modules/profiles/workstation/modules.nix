{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  modules = {
    home.enableHomeManager = mkDefault true;
    misc.kdeconnect.enable = mkDefault true;
    secrets.installAgenixCli = mkDefault true;
  };
}
