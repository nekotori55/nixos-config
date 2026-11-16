{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.programs.gui.gnome-boxes;
in
{
  options.modules.programs.gui.gnome-boxes = {
    enable = mkEnableOption "gnome boxes and virt config";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gnome-boxes ];

    virtualisation.libvirtd.enable = true;
  };
}
