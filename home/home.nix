{
  lib,
  config,
  pkgs,
  ...
}:
let
  fs = lib.fileset;
  modules = fs.toList (fs.fileFilter (file: file.name == "module.nix") ./modules);
in
{
  imports = modules;

  # System settings
  home.stateVersion = "25.05"; # TODO check if correct

  # Enable management of XDG base directories
  xdg.enable = true;

  ricing-mode = {
    # enable = true;
    globalFlakePath = config.xdg.configHome + "/nixos";
  };
}
