{ config, lib, ...}:
let
  inherit (lib) mkIf mkEnableOption mkDefault;
in
{
  options.modules.settings.nix = {
    enable = mkEnableOption "Convinient nix defaults";
  };

  config = mkIf config.modules.settings.nix.enable {
    nixpkgs.config.allowUnfree = mkDefault true;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nix.settings.trusted-users = [
      "root"
      "@wheel"
    ];
  };
}