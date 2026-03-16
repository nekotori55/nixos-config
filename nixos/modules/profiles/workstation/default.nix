{
  lib,
  config,
  pkgs,
  inputs,
  system,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
  username = config.modules.meta.username;

  niri-git = inputs.niri-git.packages.${system}.niri;
in
{
  config = mkIf (config.modules.profiles.profile == "workstation") {
    # Modules defaults
    # Ideally, this would be the only attrset here
    modules = {
      home.enableHomeManager = mkDefault true;
      misc.kdeconnect.enable = mkDefault true;
      peripherals.logitech.enable = mkDefault true;
      secrets.installAgenixCli = mkDefault true;
      # antiblock.zapret.enable = mkDefault true;
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
    programs.niri.package = niri-git;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # environment.systemPackages = with pkgs; [
    #   papirus-icon-theme
    #   adwaita-icon-theme
    # ];
    # xdg.icons.enable = true;

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
