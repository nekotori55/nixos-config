{ pkgs, ... }:
{
  # Quickshell
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    # package = pkgs.writeShellScriptBin "quickshell" ''
    # export QML_IMPORT_PATH=$HOME/.cache/matugen/quickshell:$QML_IMPORT_PATH
    # export QML2_IMPORT_PATH=$HOME/.cache/matugen/quickshell:$QML2_IMPORT_PATH
    # ${pkgs.quickshell}/bin/quickshell
    # '';
  };

  ricing-mode.files."quickshell" = {
    source = ./dotfiles/quickshell;
    # recursive = true;
  };

  home.sessionVariables = {
    # "QS_NO_RELOAD_POPUP" = 1;

  };
}
