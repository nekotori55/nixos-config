{ lib, ... }:
let
  inherit (lib) mkIf;
in
{
  # TODO make wayland condition
  programs.foot = mkIf true {
    enable = true;
    settings.main = {
      font = "Fira Code Nerd Font:size=11";
      dpi-aware = "yes";
    };
  };
}
