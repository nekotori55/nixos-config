{ pkgs, ... }:
{
  # Quickshell
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  ricing-mode.files."quickshell" = {
    source = ./dotfiles/quickshell;
  };

  # home.sessionVariables = {
  # "QS_NO_RELOAD_POPUP" = 1;
  # };
}
