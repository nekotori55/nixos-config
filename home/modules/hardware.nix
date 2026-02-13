{
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf osConfig.hardware.bluetooth.enable {
      services.mpris-proxy.enable = true;
    })

    (lib.mkIf osConfig.services.udisks2.enable {
      services.udiskie = {
        enable = true;
        settings = {
          # workaround for
          # https://github.com/nix-community/home-manager/issues/632
          program_options = {
            # replace with your favorite file manager
            file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
          };
        };
      };
    })
  ];
}
