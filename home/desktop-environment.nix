{ pkgs, ... }:
{
  #description = "user-level configuration related to desktop environment";

  # Required programs
  home.packages = with pkgs; [
    xwayland-satellite

    fuzzel # app launcher
    pavucontrol # audio settings

    # fonts
    nerd-fonts.fira-code
    font-awesome
  ];

  # Niri config
  # <put config here>

  programs.waybar = {
    enable = true;
  };

  # Terminal
  programs.foot = {
    enable = true;
    settings.main = {
      font = "Fira Code Nerd Font:size=11";
      dpi-aware = "yes";
    };
  };

  programs.quickshell.enable = true;

  # Font managment
  fonts.fontconfig.enable = true;

  ricing-mode.files."niri/config.kdl" = {
    source = ./niri-config.kdl;
  };
}
