{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = osConfig.programs.niri;
in
{
  ricing-mode.files."niri" = mkIf cfg.enable {
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
}
