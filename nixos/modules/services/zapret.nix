{ lib, config, inputs, ... }:
{
  imports = [
    inputs.zapret.nixosModules.withTestTools
  ];
  
  options.modules.services.zapret.enable = lib.mkEnableOption "zapret";


  config = lib.mkIf config.modules.services.zapret.enable {
    services.zapret-discord-youtube = {
      enable = false;
      configName = "general (FAKE_TLS_AUTO_ALT)";
    };
  };
}
