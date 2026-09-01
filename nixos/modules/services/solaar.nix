{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    # inputs.solaar.nixosModules.default
  ];

  options.modules.services.solaar = {
    enable = lib.mkEnableOption "Solaar, a logitech peripherals manager";
  };

  config = lib.mkIf config.modules.services.solaar.enable {
    # environment.systemPackages = with pkgs; [
    #   logiops
    # ];
    #

    programs.solaar = {
      enable = true;
      userService.enable = true;
    };
  };
}
