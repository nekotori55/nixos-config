{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib) mapAttrsToList;
  inherit (lib.types) listOf str bool;

  cfg = config.modules.services.ssh;

  ssh-keys-attrs = import "${inputs.self}/keys.nix";
  ssh-keys = mapAttrsToList (n: v: v) ssh-keys-attrs.workstations;
in
{
  options.modules.services.ssh = {
    enable = mkEnableOption "SSHD daemon";

    hardening = mkEnableOption "use more secure ssh defaults";

    workstationKeys = mkOption {
      readOnly = true;
      type = listOf str;
      default = ssh-keys;
    };
  };

  config = mkIf cfg.enable {
    services.sshd.enable = true;

    services.openssh = mkIf cfg.hardening {
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };

      ports = lib.mkForce [ 32233 ];
    };

  };
}
