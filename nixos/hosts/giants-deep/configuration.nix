{
  imports = [
    ./hardware
  ];

  services.nginx = {
    enable = true;
    virtualHosts = {
      "nekotori55.space" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          return = "200 '<html><body>Under construction</body></html>'";
          extraConfig = ''
            default_type text/html;
          '';
        };
      };
    };
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
