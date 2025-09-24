{ lib, ... }:
with lib;
{
  imports = [
    ./default/theme.nix
    ./windows/theme.nix
    ./dynamic/theme.nix
  ];

}
