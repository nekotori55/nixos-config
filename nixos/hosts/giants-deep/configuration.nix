{ ... }:
{
  imports = [
    ./hardware
  ];

  services.nginx = {
    enable = true;
    virtualHosts = rec {
      localhost = {
        locations."/" = {
          return = "200 '<html><body>Under construction</body></html>'";
          extraConfig = ''
            default_type text/html;
          '';
        };
      };

      "nekotori55.space" = localhost;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80 # http
    443 # https
  ];

}
