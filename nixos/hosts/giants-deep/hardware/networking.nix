{ lib, ... }:
let
  inherit (lib) splitStringBy replaceElemAt;
  calc-gateway =
    ip:
    builtins.concatStringsSep "." (
      replaceElemAt (splitStringBy (prev: curr: builtins.elem curr [ "." ]) false ip) 3 "1"
    );


  ip = "89.110.69.43";
  gateway = lib.trace (calc-gateway ip) (calc-gateway ip);
in
{
  networking = {
    domain = "nekotori55.space";
    interfaces."ens3" = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = ip;
          prefixLength = 24;
        }
      ];
      # ipv6.addresses = [
      #   {
      #     address = "2a13:7c00:6:28:f816:3eff:fe96:81d9";
      #     prefixLength = 64; # idk??
      #   }
      # ];
    };

    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    defaultGateway = gateway;

    tempAddresses = "disabled";
  };
}
