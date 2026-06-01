{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware
    inputs.foundryvtt.nixosModules.foundryvtt
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "nekotori55.space" = {
        enableACME = true;
        forceSSL = true;

        locations = {
          "/" = {
            return = "200 '<html><body>Under construction</body></html>'";
            extraConfig = ''
              default_type text/html;
            '';
          };
          "/dnd" = {
            proxyPass = "http://localhost:30000";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "nekotori55@proton.me";
  };

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
      routePrefix = "dnd";
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

  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # https
    # 30000
  ];

}
