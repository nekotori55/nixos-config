{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption optional mapAttrs mkMerge;
  inherit (lib.types) bool attrsOf attrs;

  cfg = config.modules.services.agenix;

  system = config.nixpkgs.hostPlatform.system;

  default-user = {
    enabled = config.modules.settings.default-user.enable;
    name = config.modules.settings.default-user.username;
  };

  secretsPath = "${inputs.self}/secrets";

  secretDefaults = {
    owner = "root";
    group = "root";
    mode = "400";
  };
in
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  options.modules.services.agenix = {
    enable = mkOption {
      type = bool;
      default = true;
      description = "Enable agenix secrets decryption";
    };

    secrets = mkOption {
      # let the agenix validate the attrs
      type = attrsOf attrs;
    };

    install-cli = mkEnableOption "Agenix cli";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      age.identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ]
      ++ (optional default-user.enabled "/home/${default-user.name}/.ssh/id_ed25519");

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

    (mkIf (cfg.install-cli) {
      environment.systemPackages = [
        inputs.agenix.packages."${system}".default
      ];
    })
  ];
}
