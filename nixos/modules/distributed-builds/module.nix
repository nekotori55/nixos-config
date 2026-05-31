{
  lib,
  config,
  builders,
  hostname,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    mkMerge
    types
    ;

  cfg = config.modules.distributed-builds;
  ssh-keys-set = import "${inputs.self}/keys.nix";

  allowed-keys = builtins.attrValues ssh-keys-set.workstations;

  key-path = "${config.users.users.${config.modules.meta.username}.home}/.ssh/id_ed25519";
in
{
  options.modules.distributed-builds = {
    is-builder = mkOption {
      type = types.bool;
      readOnly = true;
      default = builtins.elem hostname builders;
    };

    enable = mkEnableOption "Use distributed builds";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      nix.distributedBuilds = true;
      nix.settings.builders-use-substitutes = true;

      nix.buildMachines = map (builder: {
        hostName = builder;
        sshUser = "remotebuild";
        sshKey = key-path;
        system = pkgs.stdenv.hostPlatform.system;
        supportedFeatures = [
          "nixos-test"
          "big-parallel"
          "kvm"
        ];
      }) builders;
    })

    (mkIf cfg.is-builder {
      users.users.remotebuild = {
        isSystemUser = true;
        group = "remotebuild";
        useDefaultShell = true;

        openssh.authorizedKeys.keys = allowed-keys;
      };

      users.groups.remotebuild = { };
      nix.settings.trusted-users = [ "remotebuild" ];

    })
  ];
}
