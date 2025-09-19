{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
{
  imports = [
    ./browsers/librewolf.nix
    ./shell/git.nix
    ./vscode.nix
    inputs.jerry.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    vesktop
    firefox
    vivaldi
    obsidian
    telegram-desktop
    spotify
  ];

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

  programs.jerry = {
    enable = true;
    config = {
      player = "mpv";
      discord_presence = true;
      # use_external_menu = true;
      image_preview = true;
    };
  };
}
