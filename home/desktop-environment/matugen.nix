{ pkgs, ... }:
{
  home.packages = with pkgs; [ matugen ];

  ricing-mode.files."matugen" = {
    source = ./dotfiles/matugen;
  };
}
