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
    ;

  inherit (lib.types) path;
  inherit (lib) mapAttrs replaceString filterAttrs;
  inherit (config.lib.file) mkOutOfStoreSymlink;

  cfg = config.ricing-mode;
  configHome = config.xdg.configHome;

  # https://github.com/nix-community/home-manager/issues/5170
  fileType =
    (import "${inputs.home-manager}/modules/lib/file-type.nix" {
      inherit (config.home) homeDirectory;
      inherit lib pkgs;
    }).fileType;
in
{
  # WARNING: module is experimental, expect the unexpected, always backup files
  options.ricing-mode = {
    enable = mkEnableOption "Replace readonly nix-store symlinks with actual editable files";

    files = mkOption {
      type = fileType "xdg.configFile" "null" configHome;
      default = { };
      description = "File same as xdg.configFile, behaves as xdg.configFile when ricing-mode.enable = false";
    };

    globalFlakePath = mkOption {
      type = path;
      description = "Global path of the root of the flake e.g. /etc/nixos";
    };

    storeFlakePath = mkOption {
      type = path;
      description = "Nix store flake path";
      example = "\"\${inputs.self}\"";
      default = "${inputs.self}";
    };
  };

  config = mkMerge [
    # If cfg.enable = false, just pass files to home
    (mkIf (!cfg.enable) {
      home.file = cfg.files;
    })

    (mkIf (cfg.enable) {
      home.file = mkMerge [
        (mapAttrs (
          name: file:
          (
            file
            // (
              let
                pathOfFileRelativeToFlakeRoot = replaceString (toString cfg.storeFlakePath) "" (
                  toString file.source
                );
                globalPathOfFile = cfg.globalFlakePath + pathOfFileRelativeToFlakeRoot;
              in
              {
                source = mkOutOfStoreSymlink globalPathOfFile;
              }
            )
          )
        ) (filterAttrs (name: file: file ? source) cfg.files))
      ];
    })
  ];
}
