{
  osConfig,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = osConfig.modules.desktop.wm.niri;
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile."niri/config.kdl".text = ''
      include "config/general.kdl"
      include "config/keybinds.kdl"
      include "${config.xdg.cacheHome}/matugen/niri/colors.kdl"
      ${cfg.host-specific-config}
    '';

    ricing-mode.files."niri/config" = mkIf cfg.enable {
      source = ./config;
    };

    ricing-mode.files."matugen-templates/niri/colors.kdl" = {
      source = ./colors.kdl;
    };

    programs.matugen.templates."niri" = {
      input_path = "~/.config/matugen-templates/niri/colors.kdl";
      output_path = "~/.cache/matugen/niri/colors.kdl"; # imported in ./config/config.kdl
    };

    home.packages = with pkgs; [
      xwayland-satellite
    ];
  };
}
