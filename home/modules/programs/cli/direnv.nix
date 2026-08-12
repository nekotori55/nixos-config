{ lib, config, ... }:
{
  options.modules.programs.cli.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.modules.programs.cli.direnv.enable {
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
