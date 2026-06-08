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
        ];
        environment = {
          XRAY_VMESS_AEAD_FORCED = "false";
          XUI_ENABLE_FAIL2BAN = "true";
        };
        ports = [
          "2053:2053"
        ];
      };
    };
  };
}
