{ lib, config, ... }:
let
  # CONFIGURATION

  inherit (lib)
    splitStringBy
    replaceElemAt
    mkOption
    types
    ;

  calc-gateway =
    ip:
    builtins.concatStringsSep "." (
      replaceElemAt (splitStringBy (prev: curr: builtins.elem curr [ "." ]) false ip) 3 "1"
    );
in
{
  options = {
    ip = mkOption {
      type = types.str;
      example = "192.168.1.100";
    };

    gateway = mkOption {
      type = types.str;
      example = "192.168.1.1";
      default = calc-gateway (config.ip);
    };

    domain = mkOption {
      type = types.str;
      example = "example.com";
    };
  };

  config = {
    networking = {
      domain = config.domain;
      interfaces."ens3" = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = config.ip;
            prefixLength = 24;
          }
        ];
      };

      nameservers = [
        "8.8.8.8"
        "1.1.1.1"
      ];
      defaultGateway = config.gateway;

      tempAddresses = "disabled";
    };
  };
}
