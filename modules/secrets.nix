{
  config,
  lib,
  inputs,
  system,
  hostname,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkOption;
  inherit (lib.types) path bool;

  cfg = config.modules.secrets;
  username = config.modules.meta.username;

  # TODO move to lib
  # https://github.com/NotAShelf/nyx/blob/d407b4d6e5ab7f60350af61a3d73a62a5e9ac660/parts/lib/secrets.nix
  mkSecret = (
    enableCondition:
    {
      file,
      owner ? "root",
      group ? "root",
      mode ? "400",
    }:
    mkIf enableCondition {
      file = "${inputs.self}/other/secrets/${file}";
      inherit group owner mode;
    }
  );
in
{
  options.modules.secrets = {
    enabled = mkOption {
      type = bool;
      default = true;
      description = "Flag that allows config to run on machines without decryption keys";
    };

    installAgenixCli = mkEnableOption "Install agenix cli from input";

    secretsLocation = mkOption {
      type = path;
      readOnly = true;
      default = "${inputs.self}/other/secrets";
    };
  };

  config = mkIf cfg.enabled {
    environment.systemPackages = mkIf cfg.installAgenixCli [
      inputs.agenix.packages."${system}".default
    ];

    age.identityPaths = [
      "/home/${username}/.ssh/id_ed25519"
      "/etc/ssh/ssh_host_ed25519_key"
    ];

    age.secrets."${hostname}-password" = mkSecret true {
      file = "passwords/${hostname}.age";
    };
  };
}
