{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    
  ];

  nixpkgs.config.allowUnfree = false;

  time.timeZone = "Europe/Istanbul";

  # add on first install
#   system.stateVersion = "23.05";
}
