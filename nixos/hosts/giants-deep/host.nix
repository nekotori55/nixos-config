{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware
    ./modules.nix
    ./services
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";

  ip = "89.110.69.43";
  domain = "nekotori55.space";

}
