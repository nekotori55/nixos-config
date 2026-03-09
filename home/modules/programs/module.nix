{ lib, ... }:
let
  fs = lib.fileset;

  collectNixFiles = dir: fs.toList (fs.fileFilter (file: file.hasExt "nix") dir);

  gui-programs = collectNixFiles ./gui;
  shell-programs = collectNixFiles ./shell;
in
{
  imports = gui-programs ++ shell-programs;
}
