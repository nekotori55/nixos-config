{ config, lib, pkgs, ... }:
let 
  inherit (lib) mkIf mkEnableOption;
in 
{
  options.modules.session.desktop.plasma = {
    enable = mkEnableOption "Enable kde plasma 6";
  };

  config = mkIf config.modules.session.desktop.plasma.enable {
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs; [
      # TODO
    ];
  };
}