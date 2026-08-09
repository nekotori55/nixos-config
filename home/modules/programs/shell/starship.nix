{ config, lib, ... }:
{
  options.modules.shell.starship.enable = lib.mkEnableOption "Enable starship";

  config = lib.mkIf config.modules.shell.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}
