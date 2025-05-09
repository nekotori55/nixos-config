{ pkgs, osConfig, ... }:
{
  imports = [
    ./desktop/bspwm
    ./desktop/hyprland
    ./apps
  ];

  home = {

    packages = with pkgs; [
      telegram-desktop
    ];

    stateVersion = osConfig.system.stateVersion;
  };
}
