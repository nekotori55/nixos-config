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
      telegram-desktop
    ];

    stateVersion = osConfig.system.stateVersion;
  };
}
