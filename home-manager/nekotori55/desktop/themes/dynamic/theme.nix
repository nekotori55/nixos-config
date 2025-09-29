{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  cacheDir = osConfig.modules.home.cacheDir;
in
{
  config = lib.mkIf (osConfig.modules.desktop.theme == "dynamic") {

    home.packages = with pkgs; [
      nerd-fonts.caskaydia-cove # waybar font

      # pywal + firefox TODO autoinstall extension for firefox
      pywalfox-native
      python2 # for pywal

      themix-gui
    ];

    # DYNAMIC COLORS
    programs.pywal.enable = true;

    # TODO
    services.swaync.enable = true;

    xdg.configFile."wal/templates" = {
      source = ./wal-templates;
      recursive = true;
    };

    # hyprland coloring
    wayland.windowManager.hyprland.extraConfig = ''
      source = ${cacheDir}/wal/hyprland-colors.conf

      general { 
          col.active_border = $color10 $color11 90deg
          col.inactive_border = $color6
          bezier = linear, 0.0, 0.0, 1.0, 1.0
      }

      exec-once = wal -R
      exec-once = waybar

      # Waypaper pretty placement
      windowrule = float , class: waypaper
      windowrule = size 50%, 50%, class: waypaper
    '';

    # hyprlock coloring
    programs.hyprlock = {

      extraConfig = ''
        source = ${cacheDir}/wal/hyprlock-colors.conf
      ''
      + lib.readFile ./hyprlock/hyprlock.conf;
    };

    xdg.configFile."hypr/hyprlock" = {
      source = ./hyprlock/scripts;
      recursive = true;
    };

    # WAYBAR
    programs.waybar = {
      enable = true;
      systemd.enable = false; # better using hyprland exec-once
    };

    xdg.configFile."waybar" = {
      source = ./waybar;
      recursive = true;
    };

    xdg.configFile."waypaper/config.ini" =
      let
        homePath = osConfig.modules.home.dir;
      in
      {
        text = lib.generators.toINI { } {
          Settings = {
            language = "en";
            folder = "~/wallpapers";
            monitors = "All";
            wallpaper = "";
            show_path_in_tooltip = true;
            backend = "swww";
            fill = "fill";
            sort = "daterev";
            color = "#333333";
            subfolders = true;
            all_subfolders = true;
            show_hidden = false;
            show_gifs_only = false;
            zen_mode = true;
            post_command = "wal --saturate 0.5 -n -i $wallpaper ; pywalfox update ; pkill waypaper";
            number_of_columns = 3;
            swww_transition_type = "any";
            swww_transition_step = 90;
            swww_transition_angle = 0;
            swww_transition_duration = 2;
            swww_transition_fps = 60;
            mpvpaper_sound = false;
            mpvpaper_options = "";
            use_xdg_state = "True";
          };
        };
      };

    # apply pywal colorscheme on terminal startup
    programs.bash.bashrcExtra = "(cat ~/.cache/wal/sequences &)";

    programs.foot.settings = {
      colors = {
        alpha = 0.8; # add some transparency
      };
    };

    gtk = {
      enable = true;
      theme.name = "Materia-dark";
      theme.package = pkgs.materia-theme;
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
    };

    # ROFI-LIKE
    programs.fuzzel = {
      enable = true;
      settings =
        let
          themeSrc = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "fuzzel";
            rev = "0af0e26901b60ada4b20522df739f032797b07c3";
            sha256 = "sha256-XpItMGsYq4XvLT+7OJ9YRILfd/9RG1GMuO6J4hSGepg=";
          };
        in
        {
          main.include = toString "${themeSrc}/themes/catppuccin-mocha/green.ini";
        };
    };

    # CURSOR
    home.pointerCursor = {
      enable = true;
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      hyprcursor.enable = true;
      hyprcursor.size = 24;
      size = 24;
      # gtk.enable = true;
      # x11 = {
      # enable = true;
      # defaultCursor = "phinger-cursors-light";
      # };
    };
  };
}
