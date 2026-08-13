{ pkgs, ... }:
{
  imports = [
    ./hardware
    ./modules.nix
    ./services
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
} 