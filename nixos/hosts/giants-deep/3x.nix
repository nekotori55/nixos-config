{ ... }:
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
}

# to make it work:
# get to panel settings
# setup inbound with fallback
# use no certs
# set uri path
