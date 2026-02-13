{ pkgs, lib, ... }:
{
  imports = [
    ./quickshell.nix
    ./foot.nix
    ./niri.nix
    ./waypaper.nix
    ./matugen.nix
  ];

  # Required programs
  home.packages = with pkgs; [
    fuzzel # app launcher
    pavucontrol # audio settings
    kdePackages.dolphin
    kdePackages.dolphin-plugins

    # fonts
    nerd-fonts.fira-code
    font-awesome
    noto-fonts-cjk-serif

    # wallpapers
    swww

    # icons
    papirus-icon-theme
  ];

  # Font managment
  fonts.fontconfig.enable = true;
}
