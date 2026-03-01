{ pkgs, lib, ... }:
{
  imports = [
    ./quickshell.nix
    ./foot.nix
    ./niri.nix
    ./waypaper.nix
    ./matugen.nix
    ./fuzzel.nix
  ];

  # Required programs
  home.packages = with pkgs; [
    pavucontrol # audio settings
    brightnessctl
    playerctl
    kdePackages.dolphin
    kdePackages.dolphin-plugins

    # fonts
    nerd-fonts.fira-code
    font-awesome
    noto-fonts-cjk-serif
    comfortaa

    # wallpapers
    swww

    # icons
    papirus-icon-theme
  ];

  # Font managment
  fonts.fontconfig.enable = true;
}
