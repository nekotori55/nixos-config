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
  hyprlandKeybinds = readFile ./dotfiles/hyprland/binds.conf;
  hyprlandRules = readFile ./dotfiles/hyprland/rules.conf;
  hyprlandSettings = readFile ./dotfiles/hyprland/settings.conf;
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
        + hyprcfg.additionalConfig;
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
      source = ./dotfiles/hyprland/workspace.sh; # requires jq
      executable = true;
    };

    services.swww = {
      enable = true;
      extraArgs = [ ];
    };

    home.packages = with pkgs; [
      jq # required for script to work
      waypaper
      pavucontrol # todo move somewhere else

      nerd-fonts.fira-code
      nerd-fonts.envy-code-r
    ];

    # enable custom fonts
    fonts.fontconfig.enable = true;
  };
}
