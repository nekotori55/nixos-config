{
  pkgs,
  osConfig,
  lib,
  ...
}:
{
  imports = [
    ./desktop/bspwm
    ./desktop/hyprland
    ./apps
  ];

  home = {
    packages = with pkgs; [
      telegram-desktop

      fuzzel
      grim
      slurp
      wl-clipboard
    ];

    stateVersion = osConfig.system.stateVersion;
  };

  programs.foot = lib.mkIf (osConfig.modules.desktop.backend == "wayland") {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        font = "Fira Code Nerd Font:size=11";
        dpi-aware = "no";
        pad = "8x0";
      };

      colors = {
        background = "161623";
      };
    };
  };

}
