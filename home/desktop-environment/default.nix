{ pkgs, lib, ... }:
{
  imports = [
    ./quickshell
  ];

  # Niri
  ricing-mode.files."niri/config.kdl" = {
    source = ./niri-config.kdl;
  };

  # Terminal
  programs.foot = {
    enable = true;
    settings.main = {
      font = "Fira Code Nerd Font:size=11";
      dpi-aware = "yes";
    };
  };

  programs.waybar = {
    enable = true;
  };

  # Required programs
  home.packages = with pkgs; [
    xwayland-satellite

    fuzzel # app launcher
    pavucontrol # audio settings

    # fonts
    nerd-fonts.fira-code
    font-awesome

    # wallpapers
    waypaper
    swww

    # icons
    papirus-icon-theme
  ];

  xdg.configFile."waypaper/config.ini" = {
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

  # Font managment
  fonts.fontconfig.enable = true;
}
