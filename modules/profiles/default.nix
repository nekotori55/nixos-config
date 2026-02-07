{
  lib,
  profile,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib.types) enum;
in
{
  # imports = [
  #   ./common.nix
  #   ./workstation.nix
  #   ./server.nix
  # ];

  options.modules.profiles = {
    profile = mkOption {
      type = enum [
        "workstation"
        "server"
      ];
      default = profile;
    };
  };
}
