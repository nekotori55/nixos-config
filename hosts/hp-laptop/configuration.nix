{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  # NixOS system
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.nh.enable = true;
  programs.nh.flake = "/home/nekotori55/.config/nixos";

  # General system
  networking.hostName = "hp-laptop";
  networking.networkmanager.enable = true;
  services.sshd.enable = true;

  # Wake on Lan
  networking.interfaces.eno1.wakeOnLan.enable = true;
  networking.firewall.allowedUDPPorts = [ 9 ];

  # Locale/Time Settings
  time.timeZone = "Europe/Istanbul";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # Packages
  environment.systemPackages = with pkgs; [
    git
    wget
    helix
  ];

  # Display Manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Compositor
  programs.niri.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Users
  users = {
    mutableUsers = false;

    users.nekotori55 = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];

      hashedPassword = "$y$j9T$EBOHnjpSHK4Vp86O4A.SP0$4nF/TaJSlLQt9Q0rRb8JnWfmRSbl1jmGfqN5b7gO3SB";
    };
  };

  # Security
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.systemd}/bin/systemctl suspend";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/poweroff";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }
    ];
  };

  # Custom modules
  modules.android-dev.enable = true;

  # VM
  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-device virtio-vga-gl" # niri requires opengl
      "-display gtk,gl=on" # enable opengl support
    ];

    networking.interfaces.eno1.wakeOnLan.enable = lib.mkForce false;
  };
}
