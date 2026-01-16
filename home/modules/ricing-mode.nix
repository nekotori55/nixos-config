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
    # mapAttrs
    # types
    ;

  # inherit (lib.types)
  # submodule
  # attrsOf
  # nullOr
  # bool
  # lines
  # ;

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
  # TODO: refactor this module, git rid of lib. prefixes
  #
  # TODO: Add safeMode switch that will not rewrite files
  # if ricingMode was activated before rebuild
  #
  # TODO: Add (or don't add) symlink mode that will place symlink to flake directory file
  # instead of creating new files (need to specify flake dir manually)

  options.ricing-mode = {
    enable = mkEnableOption ''Replace nix-store symlinks with actual editable files'';
    files = mkOption {
      type = fileType "xdg.configFile" "null" config.xdg.configHome;
      default = { };
      description = ''Attribute set of files (relative to XDG_CONFIG_DIR), see xdg.configFile'';
    };
    ricingLockfileLocation = mkOption {
      type = lib.types.path;
      default = "${config.xdg.configHome}/ricing-mode.lock";
    };
  };

  config = mkMerge [
    (mkIf ricingDisabled {
      home.file = lib.mkMerge [
        (lib.mapAttrs' (
          name: file: lib.nameValuePair "${config.xdg.configHome}/${name}" file
        ) ricingMode.files)
      ];

      home.activation = {
        ricingModeDeactivation = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ -e ${ricingMode.ricingLockfileLocation} ]; then
            rm ${ricingMode.ricingLockfileLocation}
          fi 
        '';
      };
    })

    (mkIf ricingEnabled {
      home.activation = {
        ricingModeActivation =
          let
            flattenFiles =
              fileset:
              lib.listToAttrs (
                lib.flatten (
                  lib.mapAttrsToList (
                    name: file:
                    if file.text != null then
                      let
                        fullPath = config.home.homeDirectory + "/" + file.target;
                      in
                      {
                        name = toString fullPath;
                        value = {
                          inherit (file) text executable;
                          target = fullPath;
                        };
                      }
                    else if lib.pathIsDirectory file.source then
                      lib.map (
                        source:
                        let
                          pathOfSourceFolder = toString (file.source + "./..");
                          pathRelativeToConfigHome = lib.replaceString pathOfSourceFolder "" (toString source);
                          fullPath = config.xdg.configHome + pathRelativeToConfigHome;
                        in
                        {
                          name = toString fullPath;
                          value = {
                            text = lib.readFile source;
                            executable = null;
                            target = fullPath;
                          };
                        }
                      ) (lib.fileset.toList file.source)
                    else if builtins.readFileType file.source == "regular" then
                      let
                        fullPath = config.home.homeDirectory + "/" + file.target;
                      in
                      {
                        name = toString fullPath;
                        value = {
                          inherit (file) executable;
                          text = lib.readFile file.source;
                          target = fullPath;
                        };
                      }
                    else
                      abort "RicingMode: Unsupported filetype"
                  ) fileset
                )
              );

            files = flattenFiles ricingMode.files;

          in
          lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            RICING_MODE_FILE="${ricingMode.ricingLockfileLocation}"

            if [ ! -f "$RICING_MODE_FILE" ]; then
              touch "$RICING_MODE_FILE"
              NEW_MODE=1
            fi

            if [ $NEW_MODE ]; then
              ${lib.concatStringsSep "\n\n" (
                lib.mapAttrsToList (name: file: ''
                  target=${file.target}

                  # Get file target directory path
                  dir=$(dirname $target)

                  # Create folder if it doesn't exist
                  mkdir -p $dir

                  # If there is file and it's a symlink, delete it
                  if [ -L $target ]; then
                    echo "link is here. deleting"
                    rm $target
                  else
                    echo "no link"
                  fi

                  # Create target file with contents
                  touch $target
                  cat << RICING_EOF > $target
                  ${file.text}
                  RICING_EOF

                  # Add executable if needed
                  if ${if file.executable == true then "true" else "false"} ; then
                    chmod +x $target
                  fi
                '') files
              )}
            fi
          '';
      };
    })
  ];
}
