{ config, ... }:
let
  username = config.modules.meta.username;
in
{
  virtualisation.vmVariant = {
    # For niri to be able to start in vmVariant
    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
    ];

    # share user keys to be able to decrypt agenix files
    virtualisation.sharedDirectories = {
      keys = {
        source = "/home/${username}/.ssh";
        target = "/home/${username}/.ssh";
      };
    };
  };
}
