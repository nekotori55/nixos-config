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
  networking.hostname = "teclast-laptop";

  # Locale/Time Settings
  time.timeZone = "Europe/Istanbul";
  time.hardwareClockInLocalTime = true;

  # Packages
  environment.systemPackages = with pkgs; [
    git
    wget
    helix
  ];

  # Users
  users = {
    mutableUsers = true;

    nekotori55 = {
      initialPassword = "123";
    };
  };
}
