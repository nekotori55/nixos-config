{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Social
    telegram-desktop
    vesktop

    # Utilities
    trash-cli
    bitwarden-desktop
  ];
}
