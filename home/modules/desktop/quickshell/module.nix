{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.modules.desktop.quickshell.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.graphics.enabled {
    # Quickshell
    programs.quickshell = {
      enable = true;
      systemd.enable = true;
    };

    home.sessionVariables = {
      # "QS_NO_RELOAD_POPUP" = 1;
    };

    ricing-mode.files."quickshell" = {
      source = ./config;
    };

    # Matugen theming
    ricing-mode.files."matugen-templates/quickshell/colors.qml" = {
      source = ./colors.qml;
    };

    programs.matugen.templates."quickshell" = {
      input_path = "~/.config/matugen-templates/quickshell/colors.qml";
      output_path = "~/.cache/matugen/quickshell/Colors_gen.qml";
    };
  };
}
