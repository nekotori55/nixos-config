{ ... }:
{
  imports = [
    ./nvidia.nix
    ./bluetooth.nix
    ./filesystems.nix
    ./boot.nix
    ./audio.nix
  ];

  powerManagement.enable = true;
}
