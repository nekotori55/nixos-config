{
  osConfig,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = osConfig.modules.home.apps.browsers.librewolf;
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    policies = {
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      DisableAppUpdate = true;
    };

    profiles.${osConfig.modules.home.user.name}.settings = {

    }
    // cfg.preferences;
  };
}
