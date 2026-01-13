{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkMerge
    mkIf
    mapAttrs
    types
    ;

  inherit (lib.types)
    submodule
    attrsOf
    nullOr
    bool
    lines
    ;

  ricingEnabled = config.ricing-mode.enable;
  ricingDisabled = !config.ricing-mode.enable;
  ricingMode = config.ricing-mode;

  fileType =
    (import "${inputs.home-manager}/modules/lib/file-type.nix" {
      inherit (config.home) homeDirectory;
      inherit lib pkgs;
    }).fileType;
in
{
  # TODO decide if option should be declared in nixos module or in home-manager module
  # TODO implement ricing mode that replaces hardcoded nix configs with regular files
  # Maybe mkforce?

  options.ricing-mode = {
    enable = mkEnableOption ''Replace nix-store symlinks with actual editable files'';
    files = mkOption {
      type = fileType "xdg.configFile" "null" config.xdg.configHome;
      default = { };
      description = ''Attribute set of files (relative to XDG_CONFIG_DIR), see xdg.configFile'';
    };
  };

  config = mkMerge [
    (mkIf ricingDisabled {
      home.file = lib.mkMerge [
        (lib.mapAttrs' (
          name: file: lib.nameValuePair "${config.xdg.configHome}/${name}" file
        ) ricingMode.files)
      ];
    })

    (mkIf ricingEnabled {
      home.activation = {
        ricingFiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            
        '';
      };
    })
  ];
}
