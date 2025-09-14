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

  services.git-sync.enable = true;
  services.git-sync.repositories =
    let
      homePath = osConfig.modules.home.dir;
    in
    {
      wallpapers1 = {
        path = "${homePath}/wallpapers";
        uri = "git@github.com:nekotori55/wallpapers.git";
        interval = 60;
        extraPackages = with pkgs; [ git-lfs ];
      };

      studies-7 = {
        path = "${homePath}/vault/studies-7";
        uri = "git@github.com:nekotori55/studies-7.git";
        interval = 60;
      };
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
