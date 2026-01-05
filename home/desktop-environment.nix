{ pkgs, ... }:
{
  #description = "user-level configuration related to desktop environment";

  # Required programs
  home.packages = with pkgs; [
    blueman # bluetooth manager
    foot
  ];

  # Niri config
  # <put config here>

  programs.waybar = {
    enable = true;
  };
}
