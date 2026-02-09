{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  programs.kitty = {
    enable = true;
    extraConfig = "include themes.conf";
    settings = {
      confirm_os_window_close = 0;
    };
  };

  home.activation = mkIf config.programs.kitty.enable {
    createThemesConf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      KITTY_THEMES_FILE=${config.xdg.configHome}/kitty/themes.conf
      if [ ! -f "$KITTY_THEMES_FILE" ]; then
        touch "$KITTY_THEMES_FILE"
      fi
    '';
  };
}
