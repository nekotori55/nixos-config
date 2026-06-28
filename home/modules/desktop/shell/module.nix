{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.modules.wm.niri.enable {
    # Required packages
    home.packages = with pkgs; [
      # darkly-qt5 # Not compiling, try after update FIXME
      fuzzel
      kdePackages.qqc2-desktop-style
      libsForQt5.qt5ct
      qt6Packages.qt6ct
    ];

    # Env variables
    home.sessionVariables = {
      "QT_QPA_PLATFORMTHEME" = "qt6ct";
      "QT_QUICK_CONTROLS_STYLE" = "org.kde.desktop";
    };

    # Notifications (Dunst)
    services.dunst = {
      enable = true;
      configFile = config.xdg.configHome + "/dunst/dunstrclive";
    };
    ricing-mode.files."matugen-templates/dunst/dunst".source = ./dunst;
    programs.matugen.templates."dunst" = {
      input_path = "~/.config/matugen-templates/dunst/dunst";
      output_path = "~/.config/dunst/dunstrclive";
      post_hook = "dunstctl reload";
    };

    # Lockscreen
    programs.hyprlock = {
      enable = true;
      extraConfig = ''
        source = colors.conf
      '';
    };
    ricing-mode.files."matugen-templates/hypr/colors.conf".source = ./hyprlock.conf;
    programs.matugen.templates."hyprlock" = {
      input_path = "~/.config/matugen-templates/hypr/colors.conf";
      output_path = "~/.config/hypr/colors.conf";
    };

    # Fuzzel
    ricing-mode.files = {
      "fuzzel/fuzzel.ini".source = ./fuzzel.ini; # Can be constructed from attrest using toINI
      "matugen-templates/fuzzel/colors.ini".source = ./fuzzel2.ini;
    };
    programs.matugen.templates."fuzzel" = {
      input_path = "~/.config/matugen-templates/fuzzel/colors.ini";
      output_path = "~/.cache/matugen/fuzzel.ini";
    };

    # Qt theming
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
    ricing-mode.files."matugen-templates/qt/qt5.conf".source = ./qt5.conf;
    programs.matugen.templates."qt" = {
      input_path = "~/.config/matugen-templates/qt/qt5.conf";
      output_path = "~/.cache/matugen/qt5.conf";
    };

    # KDE
    ricing-mode.files."matugen-templates/kde/kdeglobals".source = ./kdeglobals;
    programs.matugen.templates."kdeglobals" = {
      input_path = "~/.config/matugen-templates/kde/kdeglobals";
      output_path = "~/.config/kdeglobals";
    };

    # Gtk theming
    gtk = {
      enable = true;
      colorScheme = "dark";
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
    ricing-mode.files."matugen-templates/gtk/colors.css".source = ./gtk2.css;
    programs.matugen.templates = {
      "gtk3" = {
        input_path = "~/.config/matugen-templates/gtk/colors.css";
        output_path = "~/.config/gtk-3.0/colors.css";
      };
      "gtk4" = {
        input_path = "~/.config/matugen-templates/gtk/colors.css";
        output_path = "~/.config/gtk-4.0/colors.css";
      };
    };
  };
}
