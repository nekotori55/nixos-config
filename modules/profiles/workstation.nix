{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
  username = config.modules.meta.username;
in
{
  config = mkIf (config.modules.profiles.profile == "workstation") {
    # Modules defaults
    # Ideally, this would be the only attrset here
    modules = {
      kdeconnect.enable = mkDefault true;
      logitech.enable = mkDefault true;
      secrets.installAgenixCli = mkDefault true;
      # ssh.sshd
    };

    # Enable flake-related commands
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Enable nix helper
    programs.nh.enable = mkDefault true;
    # TODO extract path to meta option?
    programs.nh.flake = mkDefault "/home/${username}/.config/nixos";

    # Enable network manager
    networking.networkmanager.enable = mkDefault true;

    # TODO move SDDM and Niri to separate module?
    # Display Manager
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    programs.niri.enable = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # Hardware
    #
    # DO NOT EVER SWITCH TO HEADSET PROFILE
    services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
    };

    # Enable USB automount
    services.udisks2.enable = true;

    # Don't even know where to put this
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
  };
}
