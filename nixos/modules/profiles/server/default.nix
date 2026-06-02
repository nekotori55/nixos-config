{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.modules.profiles.profile == "server") {

    # SSH
    services.openssh = {
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };

      ports = lib.mkForce [ 32233 ];
    };

    services.fail2ban = {
      enable = true;
      bantime-increment.enable = true;
    };

    # For deployment
    nix.settings.trusted-users = [ "nekotori55" ];

    # Time sync
    services.timesyncd.enable = true;
    virtualisation.vmVariant = {
      services.timesyncd.enable = lib.mkForce false;
    };
  };
}
