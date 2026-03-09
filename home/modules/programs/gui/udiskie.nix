{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  headless = osConfig.modules.meta.headless;
in
{
  config = lib.mkIf osConfig.services.udisks2.enable {
    services.udiskie = {
      enable = !headless;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          # replace with your favorite file manager
          file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
        };
      };
    };
  };
}
