{ config, lib, pkgs, ... }: 
{
  options.modules.programs.cli.archive-tools.enable = lib.mkEnableOption "Enable archive tools";

  config = lib.mkIf config.modules.programs.cli.archive-tools.enable {
    environment.systemPackages = with pkgs; [
      zip
      unzip
      rar
    ];
  };
}