{ config, lib, ... }:
let
  cfg = config.modules.desktop.kde;
in
with lib;
{
  config = mkIf cfg.enable {
    modules.desktop.backend = "x11";

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.defaultSession = "plasmax11";
    services.desktopManager.plasma6.enable = true;

    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "nekotori55";

    environment.systemPackages = with pkgs; [

    ];
  };
}
