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
    ./qt.nix
    ./notifications.nix
    ./lockscreen.nix
  ];

  # Required programs
  home.packages = with pkgs; [
    wl-clipboard
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

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

}
