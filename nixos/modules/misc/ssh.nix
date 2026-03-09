{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib) mapAttrsToList;
  inherit (lib.types) listOf str;

  cfg = config.modules.misc.ssh;
  ssh-keys = import "${inputs.self}/keys.nix";
  username = config.modules.meta.username;
in
{
  options.modules.misc.ssh = {
    workstationKeys = mkOption {
      readOnly = true;
      type = listOf str;
      default = mapAttrsToList (n: v: v) ssh-keys.workstations;
    };

    enableSshd = mkEnableOption "Enable sshd";
  };

  config = {
    users.users.${username}.openssh.authorizedKeys.keys = config.modules.misc.ssh.workstationKeys;

    services.sshd.enable = cfg.enableSshd;
  };
}
