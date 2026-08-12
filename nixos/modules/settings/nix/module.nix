{ config, lib, ...}:
let
  inherit (lib) mkIf mkOption mkDefault;
in
{
  options.modules.settings.nix = {
    enable = mkOption {
      type = lib.types.bool;
      default = true;

      description = "Enable convinient nix defaults. Enabled by default but can be disabled if necessity arises";
    };
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