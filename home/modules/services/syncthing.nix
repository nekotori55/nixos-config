{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  credentials = {
    username = config.home.username;

    # TODO: use a default password when agenix is disabled; replace assertion with a warn
    passwordFile = config.age.secrets."syncthing".path;
  };
in
{
  options.modules.services.syncthing = {
    enable = mkEnableOption "syncthing";
  };

  config = mkIf config.modules.services.syncthing.enable {
    services.syncthing = {
      enable = true;

      guiCredentials = credentials;

      settings = {
        devices."little-scout-1" = {
          name = "little-scout";
          id = "GTPKV6A-IK7NRJM-CBOH63E-7OBQYJO-QT2U66O-MGOAV7Z-KSHKUXG-4PKN4AL";
        };
        autoAcceptFolders = true;
      };
      overrideFolders = false;
    };

    modules.services.agenix.secrets."syncthing" = {
      file = "passwords/syncthing.age";
      mode = "400";
    };

    assertions = [
      {
        assertion = config.modules.services.agenix.enable;
        message = "agenix is required for syncthing module"; 
      }
    ];
  };
}
