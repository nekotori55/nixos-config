{
  lib,
  config,
  system,
  inputs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  cfg = config.modules.desktop.wm.niri;
  niri-git = inputs.niri-git.packages.${system}.niri;
in
{
  options.modules.desktop.wm.niri = {
    enable = mkEnableOption "enable niri wm";

    host-specific-config = mkOption {
      type = types.lines;
      default = "";
      description = "host specific config that can be used by home manager";
    };
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
    programs.niri.package = niri-git;
  };
}
