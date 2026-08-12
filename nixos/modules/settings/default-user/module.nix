{ config, lib, hostname, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkOption mkIf;
  inherit (lib.types) str bool;

  cfg = config.modules.settings.default-user;
  agenix-enabled = config.modules.services.agenix.enable;

  agenix-password-path = config.age.secrets."${hostname}-password".path;
in
{
  options.modules.settings.default-user = {
    enable = mkEnableOption "Enable default user creation";

    username = mkOption {
      type = str;
      default = "nekotori55";
    };
  };

  config = mkIf cfg.enable {
    users = {
      mutableUsers = mkDefault true;
      users.${cfg.username} = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [ "wheel" ];

        openssh.authorizedKeys.keys = config.modules.services.ssh.workstationKeys;
      } 
      // (lib.optionalAttrs (!agenix-enabled)
      {
        password = mkDefault "changeme";
      }) 
      // (lib.optionalAttrs (agenix-enabled) 
      {
        hashedPasswordFile = agenix-password-path;
      });

      groups.${cfg.username} = {};
    };

    modules.services.agenix.secrets."${hostname}-password" = {
      file = "passwords/${hostname}.age";
    };
  };
}