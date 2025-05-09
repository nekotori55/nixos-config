{ config, lib, pkgs, ... }:
{
  imports = [
    ./bspwm.nix
    ./hyprland.nix
  ];

  config = lib.mkIf (config.modules.desktop.backend != "none") {
    environment.systemPackages = [ pkgs.nautilus ];
  };
}
