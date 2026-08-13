{ config, lib, ... }:
{
  options.modules.settings.ssh = {
    enable = lib.mkEnableOption "Enable ssh custom settings";
  };

  config = lib.mkIf config.modules.settings.ssh.enable {
    programs.ssh = {
      enable = true; # does not enable ssh actually, this is switch for applying settings below
      enableDefaultConfig = false;

      settings = {
        "nekotori55.space" = {
          HostName = "nekotori55.space";
          User = "nekotori55";
          Port = 32233;
        };
      };
    };
  };
}
