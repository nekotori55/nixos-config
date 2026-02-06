{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib) mapAttrsToList;
  inherit (lib.types) listOf str;

  ssh-keys = import "${inputs.self}/other/keys.nix";
  username = config.modules.meta.username;
in
{
  options.modules.ssh = {
    workstationKeys = mkOption {
      readOnly = true;
      type = listOf str;
      default = mapAttrsToList (n: v: v) ssh-keys.workstations;
    };
  };

  # TODO move?
  config = {
    users.users.${username}.openssh.authorizedKeys.keys = config.modules.ssh.workstationKeys;
  };
}
