{
  lib,
  profile,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib.types) enum nullOr;
in
{
  options.modules.profiles = {
    profile = mkOption {
      type = nullOr (enum [
        "workstation"
        "server"
      ]);
      default = profile;
    };
  };
}
