{ pkgs, ... }:
{
  # Quickshell
  programs.quickshell = {
    enable = false;
    systemd.enable = true;
  };

  ricing-mode.files."quickshell" = {
    source = ./config;
  };

  home.sessionVariables = {
    "QS_NO_RELOAD_POPUP" = 1;
  };
}
