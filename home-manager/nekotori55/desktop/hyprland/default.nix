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
      source = ./dotfiles/hyprland/workspace.sh; # requires jq
      executable = true;
    };

    # HYPRPAPER
    # TODO autoload from web?
    # services.hyprpaper = {
    #   enable = true;
    #   settings = {
    #     preload = [ "$HOME/.wallpaper.png" ];
    #     wallpaper = [ ",$HOME/.wallpaper.png" ];
    #   };
    # };

    services.swww = {
      enable = true;
      extraArgs = [ ];
    };

    # WAYBAR
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };

    home.packages = with pkgs; [
      jq # required for script to work
      fuzzel
      waypaper
      pavucontrol
      hyprcursor
    ];

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

    xdg.configFile."waybar" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };

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
  };
}
