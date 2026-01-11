{ lib, config, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkMerge
    mkIf
    mapAttrs
    types
    ;

  inherit (lib.types) submodule attrsOf nullOr bool lines ;

  ricingEnabled = config.ricing-mode.enable;
  ricingMode = config.ricing-mode.files;
in
{
  # TODO decide if option should be declared in nixos module or in home-manager module
  # TODO implement ricing mode that replaces hardcoded nix configs with regular files
  # Maybe mkforce?

  options.ricing-mode = {
    enable = mkEnableOption ''Replace nix-store symlinks with actual editable files'';
    # files = mkOption {
    #   type = attrsOf (submodule {
    #     options = {
    #       enable = mkOption {
    #         type = bool;
    #         default = true;
    #       };
          
    #       executable = mkOption {
    #         type = nullOr bool;
    #         default = null;
    #       };

    #       force = mkOption {
    #         type = bool; E
    #         default = false;
    #       };

    #       ignoreLinks = mkOption {
    #         type = bool;
    #         default = false;
    #       };

    #       onChange = mkOption {
    #         type = lines;
    #         default = "";
    #       };

    #       recursive = mkOption {
    #         type = bool;
    #         default = false;
    #       };

    #       source = mkOption {
    #         type = types.path;
            
    #       };
    #     };
      # });
    # };
    #
    files = 
  };

  # config = mkMerge [
  #   (mkIf ricingEnabled {
  #     xdg.configFile = mapAttrs (name: file: {
  #       inherit (file)
  #     }) ricingFiles;
  #   })

  # ];

}
