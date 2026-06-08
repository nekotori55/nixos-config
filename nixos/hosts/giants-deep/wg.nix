{
  lib,
  config,
  pkgs,
  ...
}:
let
  secretsPath = config.modules.secrets.secretsLocation;
  wg-port = 1851;
in
{
  # WIP

  config = lib.mkIf false {
    age.secrets."awg-giants-deep" = {
      file = "${secretsPath}/awg/awg-giants-deep.age";
      owner = "root";
      group = "root";
      mode = "400";
    };
    networking = {
      nat = {
        enable = true;
        enableIPv6 = true;
        externalInterface = "ens3";
        internalInterfaces = [ "awg0" ];
      };

      wg-quick.interfaces."awg0" = {
        type = "amneziawg";
        listenPort = wg-port;
        address = [
          "192.168.2.1/32"
          "fd31:bf08:57cb::8/128"
        ];

        privateKeyFile = config.age.secrets."awg-giants-deep".path;

        peers = [
          {
            publicKey = "";
            allowedIPs = [
              "192.168.2.2/32"
              "fd31:bf08:57cb::9/128"
            ];
          }
        ];

        postUp = ''
          ${pkgs.iptables}/bin/iptables -A FORWARD -i awg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
          ${pkgs.iptables}/bin/ip6tables -A FORWARD -i awg0 -j ACCEPT
          ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
        '';

        # Undo the above
        preDown = ''
          ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
          ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
          ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
        '';
      };
    };

    # networking.firewall.allowedUDPPorts = [ wg-port ];
    # networking.firewall.allowedTCPPorts = [ wg-port ];

    boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];
  };
}
