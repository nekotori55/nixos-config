{ lib, pkgs, ... }:
with lib;
with types;
{
  options = {
    modules.desktop.bspwm = {
      enable = mkEnableOption "";

      additionalPackages = mkOption {
        type = listOf package;
        default = [ ];
      };
    };
  };
}
