{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  using-xui = true;
in
{
  imports = [
    ./hardware
    ./wg.nix
    ./3x.nix
    inputs.foundryvtt.nixosModules.foundryvtt
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "nekotori55.space" = {
        enableACME = true;

        listen = lib.mkIf using-xui [
          {
            addr = "0.0.0.0";
            port = 8080;
          }
        ];
        locations = {
          "/" = {
            return = "200 '<html><body>Under construction</body></html>'";
            extraConfig = ''
              default_type text/html;
            '';
          };
          "/foundry" = {
            proxyPass = "http://localhost:30000";
            proxyWebsockets = true;
          };
          # to make ts work first somehow login to panel
          # and set URI PATH, SAVE (!!!IMPORTANT), RELOAD (!!!IMPORTANT)
          # then reapply the config if needed
          # holy wasted hours on debug
          "/notapanel/" = {
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";

              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-Host $http_host;
              proxy_set_header X-Forwarded-Port $server_port;

              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header Range $http_range;
              proxy_set_header If-Range $http_if_range;

              proxy_redirect off;
              proxy_pass http://127.0.0.1:2053;
            '';
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

  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # https
  ];

}
