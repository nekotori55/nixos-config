{ pkgs, osConfig, ... }:
{
  imports = [
    ./desktop/bspwm
    ./desktop/hyprland
    ./apps
  ];

  home = {

    packages = with pkgs; [
      kitty
    ];

    stateVersion = osConfig.system.stateVersion;
  };
}
