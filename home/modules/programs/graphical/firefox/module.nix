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
  };

  home.packages = with pkgs; [
    pywalfox-native
  ];

  ricing-mode.files."matugen-templates/firefox/pywalfox.json".source = ./firefox.json;
  programs.matugen.templates."firefox" = {
    input_path = "~/.config/matugen-templates/firefox/pywalfox.json";
    output_path = "~/.cache/wal/colors.json";
    post_hook = "pywalfox update";
  };
}
