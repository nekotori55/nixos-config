{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = lib.mkIf config.modules.graphics.enabled {
    home.packages = with pkgs; [
      # Fileviewers
      koreader # book reader
      kdePackages.elisa # music player

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
    ];
  };
}
