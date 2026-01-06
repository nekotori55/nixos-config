{ pkgs, ... }:
{
  #description = "user-level configuration related to desktop environment";

  # Required programs
  home.packages = with pkgs; [
    blueman # bluetooth manager
    fuzzel # app launcher

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

  services = {
    # Notification daemon
    mako.enable = true;
  };

  # Font managment
  fonts.fontconfig.enable = true;
}
