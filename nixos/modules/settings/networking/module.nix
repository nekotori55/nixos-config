{ config, lib, ... }:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    replaceElemAt
    splitStringBy
    types
    ;

  calc-gateway =
    ip:
    builtins.concatStringsSep "." (
      replaceElemAt (splitStringBy (prev: curr: builtins.elem curr [ "." ]) false ip) 3 "1"
    );

  cfg = config.modules.settings.networking;
in
{
  options.modules.settings.networking = {
    static-ip = {
      enable = mkEnableOption "static ip preconfiguration";

      interface = mkOption {
        type = types.str;
        example = "ens3";
      };

      ip = mkOption {
        type = types.str;
        example = "192.168.1.100";
      };

      gateway = mkOption {
        type = types.str;
        example = "192.168.1.1";
        default = calc-gateway (cfg.static-ip.ip);
      };

      domain = mkOption {
        type = types.nullOr types.str;
        example = "example.com";
        default = null;
      };
    };
  };

  config = mkIf cfg.static-ip.enable {
    networking = {
      domain = cfg.static-ip.domain;
      interfaces."${cfg.static-ip.interface}" = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = cfg.static-ip.ip;
            prefixLength = 24;
          }
        ];
      };

      nameservers = [
        "8.8.8.8"
        "1.1.1.1"
      ];

      defaultGateway = cfg.static-ip.gateway;

      tempAddresses = "disabled";
    };
  };
}
