{ lib, config, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOptions
    mkMerge
    mkIf
    mapAttrs
    ;

  ricingEnabled = config.ricing-mode.enable;
  ricingMode = config.ricing-mode.files;
in
{
  # TODO decide if option should be declared in nixos module or in home-manager module
  # TODO implement ricing mode that replaces hardcoded nix configs with regular files
  # Maybe mkforce?

  options.ricing-mode = {
    enable = mkEnableOption ''Replace nix-store symlinks with actual editable files'';
    files = mkOptions { };
  };

  # config = mkMerge [
  #   (mkIf ricingEnabled {
  #     xdg.configFile = mapAttrs (name: file: {
  #       inherit (file)
  #     }) ricingFiles;
  #   })

  # ];

}
