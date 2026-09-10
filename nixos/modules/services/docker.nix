{ config, lib, ... }:
let

in
{
  options.modules.services.docker.enable = lib.mkEnableOption "docker";

  config = lib.mkIf config.modules.services.docker.enable {
    virtualisation.docker = {
      enable = false;
      rootless = {
        enable = true;
        setSocketVariable = true;

        daemon.settings.dns = [ "1.1.1.1" "8.8.8.8" ];
        # registry-mirrors = [ "https://mirror.gcr.io" ];
      };
    };
  };
    
}
