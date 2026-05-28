{
  config,
  osConfig,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;
  isWorkstation = osConfig.modules.meta.profile == "workstation";
  username = osConfig.modules.meta.username;
  passwordFile = config.age.secrets."syncthing".path;
in
{
  services.syncthing = mkIf isWorkstation {
    enable = true;
    guiCredentials = {
      username = username;
      passwordFile = passwordFile;
    };
    settings = {
      devices."little-scout-1" = {
        name = "little-scout";
        id = "GTPKV6A-IK7NRJM-CBOH63E-7OBQYJO-QT2U66O-MGOAV7Z-KSHKUXG-4PKN4AL";
      };
      autoAcceptFolders = true;
    };
    overrideFolders = false;
  };

  age.secrets."syncthing" = {
    file = "${inputs.self}/secrets/passwords/syncthing.age";
    mode = "400";
  };

}
