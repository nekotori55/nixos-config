{ lib, config, ... }:
{
  options.modules.shell.direnv.enable = lib.mkEnableOption "Enable direnv";

  config = lib.mkIf config.modules.shell.direnv.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    programs.git = {
      ignores = [
        ".direnv/"
        ".envrc"
      ];
    };
  };
}
