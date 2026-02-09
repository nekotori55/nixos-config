{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    optional
    ;
  inherit (lib.types) bool;
  cfg = config.modules.gamedev;
in
{
  options.modules.gamedev = {
    enable = mkEnableOption "Enable gamedev module";
    godot.enable = mkOption {
      type = bool;
      default = true;
      description = "Install godot";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
      ]
      ++ optional cfg.godot.enable godot;
  };
}
