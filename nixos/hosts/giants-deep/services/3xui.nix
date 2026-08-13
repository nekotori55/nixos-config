{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      x-ui = {
        image = "ghcr.io/mhsanaei/3x-ui:latest";
        capabilities = {
          NET_ADMIN = true;
          NET_RAW = true;
        };
        volumes = [
          "/srv/xui/db/:/etc/x-ui/"
          "/var/lib/acme/nekotori55.space/:/etc/certs"
        ];
        environment = {
          XRAY_VMESS_AEAD_FORCED = "false";
          XUI_ENABLE_FAIL2BAN = "true";
        };
        extraOptions = [ "--network=host" ];
      };
    };
  };

  services.nginx.virtualHosts."nekotori55.space" = {
    # move static website to port 8080
    # so 3xui can listen on 443 port
    listen = [
      {
        addr = "0.0.0.0";
        port = 8080;
      }
    ];

    # to make ts work first somehow login to panel
    # and set URI PATH, SAVE (!!!IMPORTANT), RELOAD (!!!IMPORTANT)
    # then reapply the config if needed
    locations = {
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

}

# to make it work:
# get to panel settings
# setup inbound with fallback
# use no certs
# set uri path
