{ lib, pkgs, ... }:
let
  fs = lib.fileset;

  collectNixFiles = dir: fs.toList (fs.fileFilter (file: file.hasExt "nix") dir);

  gui-programs = collectNixFiles ./gui;
  shell-programs = collectNixFiles ./shell;

  discordus = (
    pkgs.discord.override {
      # withOpenASAR = true; # can do this here too
      withVencord = true;
    }
  );
in
{
  imports = gui-programs ++ shell-programs;

  home.packages = with pkgs; [
    vesktop
    discordus
    telegram-desktop
    obsidian
    # bitwarden-desktop

    godot
    blender

    unzip
  ];
}
