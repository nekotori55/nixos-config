{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    waypaper
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
}
