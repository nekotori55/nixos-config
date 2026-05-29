{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.modules.profiles.profile == "server") {
    services.openssh = {
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    services.timesyncd.enable = true;

    virtualisation.vmVariant = {
      services.timesyncd.enable = lib.mkForce false;
      modules.secrets.enabled = false;
    };
  };
}
