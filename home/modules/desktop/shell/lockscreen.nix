{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      source = colors.conf
    '';
  };
}
