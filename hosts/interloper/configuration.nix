{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # NixOS system
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  # system.stateVersion = "26.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.nh.enable = true;
  programs.nh.flake = "/home/nekotori55/.config/nixos";

  # General system
  networking.hostname = "interloper";
  networking.networkmanager.enable = true;
  services.sshd.enable = true;

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
  environments.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Users
  users = {
    mutableUsers = false;

    nekotori55 = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPassword = "$y$j9T$jZ0ULg5WpZVNrN.TrCJKV/$t4XLZsQY/EHzeuOdvX7sTjKFerO7ZIx4kr2NvjdwOM2";
    };
  };

  # Custom modules
  modules = {
    gaming = {
      enable = true;
      steam = true;
      minecraft = true;
      gamescope = true;
    };
  };
}
