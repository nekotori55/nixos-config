{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Social
    telegram-desktop
    vesktop

    # Utilities
    bitwarden-desktop
  ];
}
