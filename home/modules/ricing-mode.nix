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
  ricing-mode = config.ricing-mode;
  symlink-mode = ricing-mode.symlink-mode;

  fileType =
    (import "${inputs.home-manager}/modules/lib/file-type.nix" {
      inherit (config.home) homeDirectory;
      inherit lib pkgs;
    }).fileType;
in
{
  # TODO: refactor this module, git rid of lib. prefixes

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

    symlink-mode = {
      enable = mkEnableOption ''Symlink dotfiles to flake folder instead'';
      globalFlakePath = mkOption {
        type = lib.types.path;
        description = "global path of the root of the flake ( /home/user/nixos-config )";
      };
      nixStoreFlakePath = mkOption {
        type = lib.types.path;
        description = "path of flake root in nix store (you can use simple relative paths like ../../)";
      };
    };
  };

  config = mkMerge [
    (mkIf ricingDisabled {
      # home.file = lib.mkMerge [
      # (lib.mapAttrs' (
      # name: file: lib.nameValuePair "${config.xdg.configHome}/${name}" file
      # ) ricing-mode.files)
      # ];

      home.file = ricing-mode.files;

      home.activation = {
        ricingModeDeactivation = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ -e ${ricing-mode.ricingLockfileLocation} ]; then
            rm ${ricing-mode.ricingLockfileLocation}
          fi 
        '';
      };
    })

    (mkIf (ricingEnabled && symlink-mode.enable) {
      home.file = lib.mkMerge [
        (lib.mapAttrs (
          name: file:
          (
            file
            // (
              let
                pathOfFileRelativeToFlakeRoot = lib.replaceString (toString symlink-mode.nixStoreFlakePath) "" (
                  toString file.source
                );
                globalPathOfFile = symlink-mode.globalFlakePath + pathOfFileRelativeToFlakeRoot;
              in
              {
                source = break (config.lib.file.mkOutOfStoreSymlink globalPathOfFile);
              }
            )
          )
        ) (lib.filterAttrs (name: file: file ? source) ricing-mode.files))
      ];
    })

    (mkIf (ricingEnabled && !symlink-mode.enable) {
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
                          pathOfImportDir = toString (file.source); # /nix/store/blabla/flake/dotfiles/coolfrog
                          pathRelativeToImportDir = lib.replaceString pathOfImportDir "" (toString source); # /file.txt
                          fullPath = config.home.homeDirectory + "/" + file.target + pathRelativeToImportDir; # /home/user/.config/dotfiles/coolfrog/file.txt
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

            files = flattenFiles ricing-mode.files;

          in
          lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            RICING_MODE_FILE="${ricing-mode.ricingLockfileLocation}"

            if [ ! -f "$RICING_MODE_FILE" ]; then
              touch "$RICING_MODE_FILE"
              NEW_MODE=1
            else
              NEW_MODE=0
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
