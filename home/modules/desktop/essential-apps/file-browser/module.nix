{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.modules.programs.dolphin = lib.mkEnableOption "Install Dolphin with plugins and apply custom config";

  config = lib.mkIf config.modules.graphics.enabled {
    home.packages = with pkgs; [
      kdePackages.dolphin
      kdePackages.dolphin-plugins
    ];

    ricing-mode.files."dolphinrc".source = ./dolphinrc;
  };
}
