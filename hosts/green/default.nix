{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";

  modules = {
    home.useHomeManager = true;
    desktop = {
      wm = "bspwm";
    };
  };

  # add on first install
  system.stateVersion = "25.05";
}
