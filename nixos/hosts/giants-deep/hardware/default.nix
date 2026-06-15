{ inputs, ... }:
{
  imports = [
    ./boot.nix
    ./disko.nix
    inputs.disko.nixosModules.disko
    ./networking.nix
  ];
}
