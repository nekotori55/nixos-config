{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.foundry;

in
{
  imports = [
    inputs.foundryvtt.nixosModules.foundryvtt
  ];

  options.modules.foundry = {
    enable = mkEnableOption "foundryVTT";
  };

  config = mkIf cfg.enable {
    services.foundryvtt =
      let
        foundryvtt-pkg = inputs.foundryvtt.packages.${pkgs.stdenv.hostPlatform.system}.foundryvtt;
      in
      {
        enable = true;
        hostName = "nekotori55.space";
        minifyStaticFiles = true;
        proxyPort = 443;
        proxySSL = true;
        routePrefix = "foundry";
        language = "ru.ru-ru";
        port = 30000;
        package = foundryvtt-pkg.overrideAttrs (
          final: prev:
          {
            majorVersion = "14";
            build = "360";
          }
          // prev
        );
      };

    services.nginx.virtualHosts."nekotori55.space".locations."/foundry" = {
      proxyPass = "http://localhost:30000";
      proxyWebsockets = true;
    };
  };
}
