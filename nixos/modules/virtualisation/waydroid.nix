{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.virtualisation.waydroid;
in
{
  options.modules.virtualisation.waydroid.enable = mkEnableOption "";

  config = mkIf cfg.enable {
    virtualisation.waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
  };
}
