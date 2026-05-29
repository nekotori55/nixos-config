{ config, lib, ... }:
let
  inherit (lib) mkIf;
  username = config.modules.meta.username;
in
{

  config = mkIf (config.modules.profiles.profile == "workstation") {
    virtualisation.vmVariant = {
      # For niri to be able to start in vmVariant
      virtualisation.qemu.options = [
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];

      services.timesyncd.enable = lib.mkForce false;

      # share user keys to be able to decrypt agenix files
      virtualisation.sharedDirectories = {
        keys = {
          source = "/home/${username}/.ssh";
          target = "/home/${username}/.ssh";
        };
      };
    };
  };
}
