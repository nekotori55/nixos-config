{
  config,
  lib,
  pkgs,
  system,
  hostname,
  profile,
  ...
}:
let
  inherit (lib) mkDefault;
in
{
  options.profiles = {
    profile = lib.mkOption {
      type = lib.types.enum [
        "workstation"
        "server"
      ];
      default = profile;
    };
  };

  config = lib.mkMerge [
    # DEFAULT
    {
      # Nix settings
      nixpkgs.hostPlatform = system;
      nixpkgs.config.allowUnfree = true;

      # Core services
      networking.hostName = mkDefault hostname;
      networking.networkmanager.enable = mkDefault true;
      services.sshd.enable = mkDefault true;

      # Locale/Time Settings
      time.timeZone = mkDefault "Europe/Istanbul";
      i18n.defaultLocale = mkDefault "en_US.UTF-8";

      # System packages
      environment.systemPackages = with pkgs; [
        git
        wget
        helix
      ];

      # Setup user
      users = {
        mutableUsers = mkDefault false;
        users.nekotori55 = {
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          password = mkDefault "changeme";
        };
      };

      # Helper meta option
      virtualisation.vmVariant = {
        modules.meta.isVmVariant = mkDefault true;
      };
    }

    # WORKSTATION
    (lib.mkIf (config.profiles.profile == "workstation") {
      # Enable flakes and NH
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      programs.nh.enable = mkDefault true;
      programs.nh.flake = mkDefault "/home/nekotori55/.config/nixos";

      # System packages
      environment.systemPackages = with pkgs; [
        nautilus # for niri
      ];

      # Display Manager
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      # Compositor
      programs.niri.enable = true;
      programs.niri.useNautilus = true;
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };

      # Modules defaults
      modules = {
        kdeconnect.enable = mkDefault true;
        logitech.enable = mkDefault true;
        secrets.installAgenixCli = mkDefault true;
      };

      # VmVariant
      virtualisation.vmVariant = {
        # For niri to be able to start in vmVariant
        virtualisation.qemu.options = [
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
        ];

        # share user keys to be able to decrypt agenix files
        virtualisation.sharedDirectories = {
          keys = {
            source = "/home/nekotori55/.ssh";
            target = "/home/nekotori55/.ssh";
          };
        };
      };
    })

    # server
    (lib.mkIf (config.profiles.profile == "server") {

    })
  ];
}
