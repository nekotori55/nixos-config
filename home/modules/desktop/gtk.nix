{ config, pkgs, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    # TODO change, not like it works lol
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };
    font = {
      package = pkgs.comfortaa;
      name = "Comfortaa";
      size = 10;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    gtk3.theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    gtk3.extraCss = "@import url(\"file://${config.xdg.configHome}/gtk-3.0/colors.css\");";
    gtk4.extraCss = "@import url(\"file://${config.xdg.configHome}/gtk-3.0/colors.css\");";
  };
}
