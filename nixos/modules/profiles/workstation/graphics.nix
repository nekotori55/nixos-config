{
  inputs,
  system,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
in
{
  config = mkIf (config.modules.profiles.profile == "workstation") {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    modules.desktop.wm.niri.enable = mkDefault true;
  };
}
