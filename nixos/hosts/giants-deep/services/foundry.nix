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
    services = {
      foundryvtt =
        let
          # fixes unfree error
          # https://github.com/nix-foundryvtt/nix-foundryvtt/issues/49#issuecomment-4848367430
          foundryvtt-pkg = (pkgs.callPackage "${inputs.foundryvtt}/pkgs/foundryvtt" { });
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
              build = "370";
            }
            // prev
          );
        };

      nginx.virtualHosts."${config.domain}" =
        let
          foundry-url-path = "/foundry";
        in
        {
          locations = {
            "${foundry-url-path}" = {
              proxyPass = "http://localhost:30000";
              proxyWebsockets = true;
            };

            "/dnd" = {
              return = "301 https://${config.domain + foundry-url-path}";
            };
          };
        };
    };
  };
}
