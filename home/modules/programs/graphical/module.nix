{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
{
  config = lib.mkIf (!osConfig.modules.meta.headless) {
    home.packages = with pkgs; [
      # Fileviewers
      koreader # book reader

      # Social
      telegram-desktop

      # Editors
      blender
      godot
      reaper # music composing software
      obsidian

      # Utility
      filezilla # ftp filebrowser
      obs-studio
      qbittorrent

      # Web browsers
      ungoogled-chromium
    ];
  };

}
