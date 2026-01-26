{ pkgs, ... }:
{
  imports = [
    ./quickshell
  ];

  # Niri
  ricing-mode.files."niri/config.kdl" = {
    source = ./niri-config.kdl;
  };

  # Terminal
  programs.foot = {
    enable = true;
    settings.main = {
      font = "Fira Code Nerd Font:size=11";
      dpi-aware = "yes";
    };
  };

  programs.waybar = {
    enable = true;
  };

  # Required programs
  home.packages = with pkgs; [
    xwayland-satellite

    fuzzel # app launcher
    pavucontrol # audio settings

    # fonts
    nerd-fonts.fira-code
    font-awesome
  ];

  # Font managment
  fonts.fontconfig.enable = true;
}
