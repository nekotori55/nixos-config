{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.graphics.enabled {
    home.packages = with pkgs; [
      kdePackages.dolphin
      kdePackages.dolphin-plugins
    ];

    ricing-mode.files."dolphinrc".source = ./dolphinrc;
  };
}
