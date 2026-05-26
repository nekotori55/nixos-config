{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  headless = osConfig.modules.meta.headless;
in
{
  programs.firefox = mkIf (!headless) {
    enable = true;
    package = pkgs.librewolf;
    # TODO add extensions and parameters
  };

  home.packages = with pkgs; [
    pywalfox-native
  ];
}
