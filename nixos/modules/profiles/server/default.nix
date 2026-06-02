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

      ports = lib.mkForce [ 32233 ];
    };

    services.timesyncd.enable = true;
    nix.settings.trusted-users = [ "nekotori55" ];

    virtualisation.vmVariant = {
      services.timesyncd.enable = lib.mkForce false;
    };
  };
}
