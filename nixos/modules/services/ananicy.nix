{ lib, config, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption;
in
{
    options.modules.services.ananicy = {
      enable = mkEnableOption "Ananicy, daemon managing nice value using rules";
    };

    config = mkIf config.modules.services.ananicy.enable {
      services.ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-cpp;
        extraRules = [
          {
            "name" = "gamescope";
            "nice" = -10;
          }
          {
            "name" = "java";
            "nice" = -10;
          }
        ];
      };
    };
}