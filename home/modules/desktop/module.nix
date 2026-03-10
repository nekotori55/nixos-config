{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./quickshell.nix
    ./foot.nix
    ./niri.nix
    ./waypaper.nix
    ./matugen.nix
    ./fuzzel.nix
    ./gtk.nix
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

    papirus-icon-theme
    papirus-folders
  ];

  # Font managment
  fonts.fontconfig.enable = true;

}
