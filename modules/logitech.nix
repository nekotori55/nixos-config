{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.logitech;
in
{
  options.modules.logitech.enable = lib.mkEnableOption "enable logitech devices management";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      logiops
    ];

    services.solaar = {
      enable = true; # Enable the service
      package = pkgs.solaar; # The package to use
      window = "hide"; # Show the window on startup (show, *hide*, only [window only])
      batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
      extraArgs = ""; # Extra arguments to pass to solaar on startup
    };
  };
}
