{
  osConfig,
  lib,
  pkgs,
  ...
}:
with lib;
# with builtins;
let
  hyprcfg = osConfig.modules.desktop.hyprland;

  # merge this in one file?
  hyprlandKeybinds = readFile ./hyprland/binds.conf;
  hyprlandRules = readFile ./hyprland/rules.conf;
  hyprlandSettings = readFile ./hyprland/settings.conf;

in
{
  config = mkIf hyprcfg.enable {

    # HYPRLAND
    wayland.windowManager.hyprland = {
      enable = true;
      # plugins
      extraConfig =
      hyprlandKeybinds
        + hyprlandRules
        + hyprlandSettings
        + (optionalString (hyprcfg.mutableConfigFile.enable) "source = ${hyprcfg.mutableConfigFile.path} \n")
        + hyprcfg.hostConfig;
    };

    home.activation = mkIf hyprcfg.mutableConfigFile.enable {
      hyprlandMutableFile = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [[ ! -f "${hyprcfg.mutableConfigFile.path}" ]]; then
          dirname -z "${hyprcfg.mutableConfigFile.path}" | xargs -0 mkdir -p
          touch "${hyprcfg.mutableConfigFile.path}"
        fi;
      '';
    };

    xdg.configFile."hypr/workspace.sh" = {
      source = ./hyprland/workspace.sh; # requires jq
      executable = true;
    };

    # HYPRPAPER
    # TODO autoload from web?
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = ["$HOME/.wallpaper.png"];
        wallpaper = [",$HOME/.wallpaper.png"];
      };
    };

    # WAYBAR
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };

    home.packages = with pkgs; [
      jq # required for script to work
      fuzzel
    ];

    xdg.configFile."waybar" = {
      source = ./waybar;
      recursive = true;
    };
  };
}
