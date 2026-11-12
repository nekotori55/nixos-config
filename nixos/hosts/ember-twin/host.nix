{ inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  nixpkgs.system = "x86_64-linux";

  wsl.enable = true;
  system.stateVersion = "24.05";

  wsl.defaultUser = "nekotori55";
}
