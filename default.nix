{ lib, ... }:
with lib;
{
  # TODO description = "Essential stuff for every system (hardware and systemsystem stuff)";

  imports = [
    ./modules
    ./options
    ./home-manager
  ];

  fileSystems."/".device = mkDefault "/dev/disk/by-label/nixos";

  # enable the laptop stuff (probably should move to host specific config)
  hardware.enableRedistributableFirmware = mkDefault true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";

      auto-optimise-store = mkDefault true; # debatable
    };
  };

  # Not needed on a server???
  # TODO move to separate desktop only profile
  # or even in host-specific file
  # VM Settings
  virtualisation.vmVariant = {
    services.spice-vdagentd.enable = true;

    virtualisation = {
      diskSize = 5192;
      memorySize = 4096;
      cores = 2;
    };

    # virtualisation.qemu.options = [
    #   # Better display option
    #   "-vga virtio"
    #   "-display gtk,zoom-to-fit=false,show-cursor=on"
    #   # Enable copy/paste
    #   # https://www.kraxel.org/blog/2021/05/qemu-cut-paste/ # TODO
    #   "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on"
    #   "-device virtio-serial-pci"
    #   "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
    # ];
  };
}
