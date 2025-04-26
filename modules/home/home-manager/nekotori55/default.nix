{ pkgs, ... }:
{
  imports = [
    ./desktop/bspwm
    ./desktop/hyprland
  ];

  home = {

    packages = with pkgs; [
      kitty
    ];

    stateVersion = "25.05";
  };
}
