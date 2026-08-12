{ lib, config, ... }:
{
  options.modules.programs.cli.bash.enable = lib.mkEnableOption "bash settings management";

  config = lib.mkIf config.modules.programs.cli.bash.enable {
    programs.bash.enable = true;
  };
}
