{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.programs.gui.dnd-tools;
in
{
  options.modules.programs.gui.dnd-tools = {
    enable = lib.mkEnableOption "dnd stuff";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wonderdraft
      (pkgs.callPackage ./dungeondraft.nix { })
    ];
  };
}
