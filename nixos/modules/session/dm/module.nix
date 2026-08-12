{ config, lib, ... }:
let

in
{
  options.modules.session.dm.sddm = {
    enable = lib.mkEnableOption "Enable sddm";
  };

  config = lib.mkIf config.modules.session.dm.sddm.enable {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
  };
}