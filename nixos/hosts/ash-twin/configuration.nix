{ lib, ... }: 
{
  imports = [
    ./hardware
    ./specialisations
    ./modules.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";

  # For dualbooting
  time.hardwareClockInLocalTime = false;
}