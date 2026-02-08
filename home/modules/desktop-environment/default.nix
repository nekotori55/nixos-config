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

    # fonts
    nerd-fonts.fira-code
    font-awesome

    # wallpapers
    swww

    # icons
    papirus-icon-theme
  ];

  # Font managment
  fonts.fontconfig.enable = true;
}
