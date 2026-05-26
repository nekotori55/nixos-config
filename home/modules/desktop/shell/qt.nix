{ config, pkgs, ... }:
{
  qt = rec {
    style.package = pkgs.darkly;

    enable = true;
    qt5ctSettings = {
      Appearance = {
        color_scheme_path = "${config.xdg.cacheHome}/matugen/qt5.conf";
        custom_palette = true;
        icon_theme = "Papirus";
        style = "Darkly";
      };
      Fonts = {
        fixed = "\"Comfortaa,10\"";
        general = "\"Comfortaa,10\"";
      };
    };
    qt6ctSettings = qt5ctSettings;
  };

  home.sessionVariables = {
    "QT_QPA_PLATFORMTHEME" = "qt6ct";
    "QT_QUICK_CONTROLS_STYLE" = "org.kde.desktop";
  };

  home.packages = with pkgs; [
    # darkly-qt5 # Not compiling, try after update FIXME
    kdePackages.qqc2-desktop-style
    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];

  ricing-mode.files = {
    "dolphinrc".source = ./dotfiles/dolphinrc;
  };
}
