{ lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
  config = lib.mkIf config.modules.graphics.enabled {
    # TODO make wayland condition
    programs.foot = mkIf true {
      enable = true;
      settings.main = {
        font = "Fira Code Nerd Font:size=11";
        dpi-aware = "yes";
      };
    };
  };
}
