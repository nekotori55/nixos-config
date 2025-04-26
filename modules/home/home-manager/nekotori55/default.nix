{ pkgs, ... }:
{
  imports = [
    ./desktop/bspwm
  ];

  home = {

    packages = with pkgs; [
      kitty
    ];

    stateVersion = "25.05";
  };
}
