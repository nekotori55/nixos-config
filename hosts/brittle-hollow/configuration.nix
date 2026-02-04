{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # NixOS system
  nixpkgs.hostPlatform = {
    system = "aarch64-linux";
  };
  tPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  # system.stateVersion = "26.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.nh.enable = true;
  programs.nh.flake = "/home/nekotori55/.config/nixos";

  # General system
  networking.hostName = "brittle-hollow";
  networking.networkmanager.enable = true;
  services.sshd.enable = true;
  boot.kernelParams = [

  ];

  # Locale/Time Settings
  time.timeZone = "Europe/Instanbul";
  time.hardwareClockInLocalTime = false;
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

  users = {
    mutableUsers = false;

    users.nekotori55 = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];

      hashedPassword = "$y$j9T$a1jAVDivYi1NOjqUg69pj1$.Wv/PFpglwKzkECtVu67Oo1zS3rq4kvnDdud8/t/zPD";
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
  modules = {
    gaming = {
      enable = true;
      steam = true;
      minecraft = true;
      gamescope = true;
    };

    android-dev.enable = false;
  };

  # VM
  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-device virtio-vga-gl" # niri requires opengl
      "-display gtk,gl=on" # enable opengl support
    ];
  };
}
