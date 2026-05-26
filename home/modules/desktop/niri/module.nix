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
    source = ./dotfiles/niri;
  };

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}
