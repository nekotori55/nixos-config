{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.solaar.nixosModules.default
  ];

  options.modules.services.solaar = {
    enable = lib.mkEnableOption "Solaar, a logitech peripherals manager";
  };

  config = lib.mkIf config.modules.services.solaar.enable {
    # environment.systemPackages = with pkgs; [
    #   logiops
    # ];

    services.solaar = {
      enable = true; # Enable the service
      package = pkgs.solaar; # The package to use
      window = "hide"; # Show the window on startup (show, *hide*, only [window only])
      batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
      extraArgs = ""; # Extra arguments to pass to solaar on startup
    };
  };
}