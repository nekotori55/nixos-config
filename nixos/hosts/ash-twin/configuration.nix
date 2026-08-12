{ lib, pkgs, ... }: 
{
  imports = [
    ./hardware
    ./specialisations
    ./modules.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}