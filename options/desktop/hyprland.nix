{ options, lib, ... }:
with lib;
{
  options = {
    modules.desktop.hyprland.enable = mkEnableOption "";
  };
}
