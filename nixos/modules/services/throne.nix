{ config, lib, ... }:
{
  options.modules.services.throne = {
    enable = lib.mkEnableOption "Enable throne";
  };

  config = lib.mkIf config.modules.services.throne.enable {
    programs.throne = {
      enable = true;
      tunMode.enable = true;
    };
  };
}