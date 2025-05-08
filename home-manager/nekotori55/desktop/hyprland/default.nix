{
  osConfig,
  lib,
  ...
}:
with lib;
# with builtins;
let
  cfg = osConfig.modules.desktop.hyprland;

  # merge this in one file?
  hyprlandKeybinds = readFile ./hyprland/binds.conf;
  hyprlandRules = readFile ./hyprland/rules.conf;
  hyprlandSettings = readFile ./hyprland/settings.conf;


in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig =
      hyprlandKeybinds
        + hyprlandRules
        + hyprlandSettings
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

    # TODO improve
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
