{ inputs, system, ... }:
let
  niri-git = inputs.niri-git.packages.${system}.niri;
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.niri.enable = true;
  programs.niri.package = niri-git;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
