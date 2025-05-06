{
  osConfig,
  lib,
  ...
}:
with lib;
# with builtins;
let
  cfg = osConfig.modules.desktop.hyprland;
  keybinds = readFile ./binds.conf;
  rules = readFile ./rules.conf;
  settings = readFile ./settings.conf;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig =
        keybinds
        + rules
        + settings
        + (optionalString (cfg.mutableConfigFile.enable) "source = ${cfg.mutableConfigFile.path} \n")
        + cfg.hostConfig;
    };

    home.activation = mkIf cfg.mutableConfigFile.enable {
      hyprlandMutableFile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [[ ! -f "${cfg.mutableConfigFile.path}" ]]; then
          dirname -z "${cfg.mutableConfigFile.path}" | xargs -0 mkdir -p
          touch "${cfg.mutableConfigFile.path}"
        fi;
      '';
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = ["$HOME/wallpaper.png"];
        wallpaper = [",$HOME/wallpaper.png"];
      };
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
