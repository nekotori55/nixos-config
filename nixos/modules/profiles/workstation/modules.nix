{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  modules = {
    home.enableHomeManager = mkDefault true;
    misc.kdeconnect.enable = mkDefault true;
    peripherals.logitech.enable = mkDefault true;
    secrets.installAgenixCli = mkDefault true;
    # antiblock.zapret.enable = mkDefault true;
  };
}
