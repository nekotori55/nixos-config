{
  pkgs,
  lib,
  config,
  ...
}:
let
  restic = "${pkgs.restic}/bin/restic";

  cfg = config.modules.programs.cli.backuper;
in
{
  options.modules.programs.cli.backuper = {
    enable = lib.mkEnableOption "wrapper around restic";

    paths = lib.mkOption {
      # TODO add regex check
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "/var/lib/amogus"
      ];
    };

    repo = lib.mkOption {
      type = lib.types.str;
      example = "rest:http://localhost:8000";
    };

  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages =
      let
        paths-to-backup = lib.join " " cfg.paths;
        repo = cfg.repo;

        # backuper = pkgs.writeShellScriptBin "backuper" ''
        #   # TODO: check if ssh tunnel exists 

        #   # Backup
        #   ${restic} -r ${repo} backup ${paths-to-backup}
        # '';
      in
      [
        # backuper
        pkgs.restic
      ];
  };
}
