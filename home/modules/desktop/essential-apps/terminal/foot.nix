{ lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
  options.modules.programs.foot.enable = lib.mkEnableOption "enable foot";

  config = lib.mkIf config.modules.programs.foot.enable {
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
