{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption mapAttrs mkMerge;
  inherit (lib.types) bool attrsOf attrs;

  cfg = config.modules.services.agenix;

  secretsPath = "${inputs.self}/secrets";

  secretDefaults = {
    mode = "400";
  };
in
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  options.modules.services.agenix = {
    enable = mkEnableOption "agenix secrets decryption";

    secrets = mkOption {
      # let the agenix validate the attrs
      type = attrsOf attrs;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      age.identityPaths =
      [
        "/home/${config.home.username}/.ssh/id_ed25519"
      ];

      age.secrets = mapAttrs (
        name: value: 
          secretDefaults 
          // value 
          // { file = "${secretsPath}/${value.file}";}
        ) cfg.secrets;

    })

    (mkIf (!cfg.enable) {
      age.secrets = lib.mkForce { };
    })
  ];
}
