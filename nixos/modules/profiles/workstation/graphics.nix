{
  inputs,
  system,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  niri-git = inputs.niri-git.packages.${system}.niri;
in
{
  config = mkIf (config.modules.profiles.profile == "workstation") {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    programs.niri.enable = true;
    programs.niri.package = niri-git;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
