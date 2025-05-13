{ lib, pkgs, ... }:
with lib;
with types;
{
  options = {
    modules.desktop.kde = {
      enable = mkEnableOption "";
    };
  };
}
