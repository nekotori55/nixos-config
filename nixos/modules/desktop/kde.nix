{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.modules.desktop.wm.plasma = {
    enable = mkEnableOption "enable kdeplasma";
  };

  config = mkIf config.modules.desktop.wm.plasma.enable {
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs; [
      kdePackages.kdepim-runtime # Akonadi agents
      kdePackages.kmahjongg
      # kdePackages.konversation # IRC client
      # kdePackages.ksudoku
      kdePackages.ktorrent
    ];

    environment.systemPackages = with pkgs; [
      kdePackages.krdp
      kdePackages.krdc
    ];

    services.xrdp = {
      enable = true;
      defaultWindowManager = "startplasma-x11";
      openFirewall = true;
    };

    services.xserver = {
      enable = true;
      # xkb = {
      #   layout = "us";
      #   variant = "";
      # };
    };
  };
}
