{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Messengers
    telegram-desktop
    ungoogled-chromium

    # Useful
    bitwarden-desktop
  ];
}
