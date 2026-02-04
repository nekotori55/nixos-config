{
  config,
  lib,
  inputs,
  ...
}:
let
  # FIXME find a better way
  system = config.nixpkgs.hostPlatform.system;

  # https://github.com/NotAShelf/nyx/blob/d407b4d6e5ab7f60350af61a3d73a62a5e9ac660/parts/lib/secrets.nix
  mkSecret = (
    enableCondition:
    {
      file,
      owner ? "root",
      group ? "root",
      mode ? "400",
    }:
    lib.mkIf enableCondition {
      file = "${inputs.self}/other/secrets/${file}";
      inherit group owner mode;
    }
  );
in
{
  options.modules.secrets = {
    installAgenixCli = lib.mkEnableOption "whether to install agenix from flake input or not";
    secretsLocation = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      default = ../other/secrets;
    };
  };

  config = lib.mkIf config.modules.secrets.installAgenixCli {
    environment.systemPackages = [ inputs.agenix.packages."${system}".default ];

    age.identityPaths = [
      "/home/nekotori55/.ssh/id_ed25519"
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    age.secrets.ash-twin-password = mkSecret true { file = "passwords/ash-twin.age"; };
    age.secrets.brittle-hollow-password = mkSecret true { file = "passwords/brittle-hollow.age"; };
    age.secrets.interloper-password = mkSecret true { file = "passwords/interloper.age"; };
  };
}
