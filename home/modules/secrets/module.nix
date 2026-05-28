{
  config,
  osConfig,
  lib,
  ...
}:
let
  inherit (lib) mkIf;

  secretsEnabled = osConfig.modules.secrets.enabled;
  secretsLocation = osConfig.modules.secrets.secretsLocation;

  mkSecret =
    enableCondition:
    {
      file,
      mode ? "400",
      symlink ? true,
    }:
    mkIf enableCondition {
      file = "${secretsLocation}/${file}";
      inherit mode symlink;
    };
in
{
  config = mkIf secretsEnabled {
    age = {
      identityPaths = osConfig.age.identityPaths;
      secretsDir = "${config.xdg.cacheHome}/asix";
    };
  };
}
