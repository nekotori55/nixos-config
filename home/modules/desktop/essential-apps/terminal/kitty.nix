{
  config,
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  headless = osConfig.modules.meta.headless;
in
{
  config = mkIf (!headless) {
    programs.kitty = {
      enable = true;
      extraConfig = "include themes.conf";
      settings = {
        confirm_os_window_close = 0;
        window_margin_width = "8 8";
      };
      keybindings = {
        "alt+t" = "new_os_window_with_cwd";
      };
    };

    home.activation = mkIf config.programs.kitty.enable {
      createThemesConf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        KITTY_THEMES_FILE=${config.xdg.configHome}/kitty/themes.conf
        if [ ! -f "$KITTY_THEMES_FILE" ]; then
          mkdir -p `dirname $KITTY_THEMES_FILE`
          touch "$KITTY_THEMES_FILE"
        fi
      '';
    };

    ricing-mode.files."matugen-templates/kitty/matugen-theme.conf" = {
      source = ./kitty-matugen-theme.conf;
    };

    programs.matugen.templates."kitty" = {
      input_path = "~/.config/matugen-templates/kitty/matugen-theme.conf";
      output_path = "~/.config/kitty/themes/Matugen.conf";
      post_hook = "kitty +kitten themes --config-file-name=themes.conf --reload-in=all Matugen && pkill kitty --signal SIGUSR1";
    };
  };
}
