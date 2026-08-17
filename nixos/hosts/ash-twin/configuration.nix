{ lib, pkgs, ... }: 
{
  imports = [
    ./hardware
    ./specialisations
    ./services
    ./modules.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";

  networking.networkmanager.enable = true;
}
