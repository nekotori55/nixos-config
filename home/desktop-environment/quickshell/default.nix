{ pkgs, ... }:
{
  # Quickshell
  programs.quickshell = {
    enable = true;
    systemd.enable = false;
  };

  ricing-mode.files."quickshell" = {
    source = ./config;
  };

  home.sessionVariables = {
    "QS_NO_RELOAD_POPUP" = 1;
  };
}
