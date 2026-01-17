{
  lib,
  ...
}:
let
  fs = lib.fileset;
  programs = fs.toList (fs.fileFilter (file: file.hasExt "nix") ./programs);
in
{
  imports = [
    ./desktop-environment
    ./modules
  ]
  ++ programs;

  # System settings
  home.stateVersion = "25.05"; # TODO check if correct
}
