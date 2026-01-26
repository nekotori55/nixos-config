{ osConfig, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf osConfig.hardware.bluetooth.enable {
      services.mpris-proxy.enable = true;
    })
  ];
}
