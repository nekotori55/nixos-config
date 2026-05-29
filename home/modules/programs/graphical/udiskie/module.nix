{
  osConfig,
  lib,
  pkgs,
  config,
  ...
}:
let
  graphics = config.modules.graphics.enabled;
in
{
  config = lib.mkIf (osConfig.services.udisks2.enabl && graphics) {
    services.udiskie = {
      enable = !graphics;
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
