{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./quickshell.nix
    ./foot.nix
    ./niri.nix
    ./waypaper.nix
    ./matugen.nix
    ./fuzzel.nix
  ];

  # Required programs
  home.packages = with pkgs; [
    pavucontrol # audio settings
    brightnessctl
    playerctl
    kdePackages.dolphin
    kdePackages.dolphin-plugins

    # fonts
    nerd-fonts.fira-code
    font-awesome
    noto-fonts-cjk-serif
    comfortaa

    # wallpapers
    swww

    papirus-icon-theme
    papirus-folders
  ];

  # Font managment
  fonts.fontconfig.enable = true;

  gtk = rec {
    enable = true;
    colorScheme = "dark";
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

    gtk3.extraCss = "@import url(\"file://${config.xdg.configHome}/gtk-3.0/colors.css\");";
    gtk4.extraCss = "@import url(\"file://${config.xdg.configHome}/gtk-3.0/colors.css\");";
    # gtk4.enable = false;
  };

  # dconf.settings = {
  #   "org/gtk/Settings/Debug" = {
  #     enable-inspector-keybinding = true;
  #   };
  # };
}
