{ config, lib, ... }:
let
  ssh-keys = import ../other/ssh-keys.nix;
in
{
  options.modules.ssh = {
    workstationKeys = lib.mkOption {
      readOnly = true;
      type = lib.types.listOf lib.types.str;
      default = lib.mapAttrsToList (n: v: v) ssh-keys.workstations;
    };
  };

  # TODO move?
  config = {
    users.users.nekotori55.openssh.authorizedKeys.keys = config.modules.ssh.workstationKeys;
  };
}
