{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fuzzel
  ];

  ricing-mode.files."fuzzel/fuzzel.ini".source = ./dotfiles/fuzzel.ini;
}
