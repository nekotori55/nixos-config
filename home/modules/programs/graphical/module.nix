{ lib, pkgs, ... }:
let
  discord-with-vencord = (
    pkgs.discord.override {
      withVencord = true;
    }
  );

  # TODO collect files
  # TODO make a graphic applications switch
in
{
  home.packages = with pkgs; [
    # Fileviewers
    koreader # book reader
    kdePackages.elisa # music player

    # Social
    vesktop
    discord-with-vencord
    telegram-desktop

    # Editors
    blender
    godot
    reaper # music composing software
    obsidian

    # Utility
    filezilla # ftp filebrowser
    obs-studio
  ];
}
