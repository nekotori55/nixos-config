{ lib, ... }:
{
  imports = [
    ./nvidia.nix
    ./bluetooth.nix
    ./filesystems.nix
    ./boot.nix
    ./audio.nix
    ./kernel.nix
  ];

  powerManagement.enable = true;
  hardware.enableRedistributableFirmware = lib.mkDefault true;
  time.hardwareClockInLocalTime = false;
}
