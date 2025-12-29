{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # NixOS system
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";

  # General system
  networking.hostName = "hp-laptop";

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

  # Users
  users = {
    mutableUsers = true;

    users.nekotori55 = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];

      initialHashedPassword = "$y$j9T$EBOHnjpSHK4Vp86O4A.SP0$4nF/TaJSlLQt9Q0rRb8JnWfmRSbl1jmGfqN5b7gO3SB";
    };
  };
}
