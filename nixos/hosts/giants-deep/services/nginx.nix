{
  inputs,
  pkgs,
  lib,
  ...
}:
{

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # virtualHosts = {
    #   # prevent host ip access
    #   "0.0.0.0" = {
    #     # addSSL = false;
    #     # enableACME = false;

    #     locations = {
    #       "/.well-known/acme-challenge/" = {
    #         extraConfig = ''allow all;'';
    #     }; 
        
    #     # extraConfig = ''
    #     #   deny all;
    #     # '';
    #   };
    # };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "nekotori55@proton.me";
  };

  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # https
  ];
}
