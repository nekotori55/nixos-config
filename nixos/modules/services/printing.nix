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
  options.modules.services.printing = {
    enable = mkEnableOption "cups and other printing stuff";
  };

  config = mkIf config.modules.services.printing.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        samsung-unified-linux-driver
      ];
    };
    environment.systemPackages = with pkgs; [
      system-config-printer
    ];
  };
}
