{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";

  user.name = "nekotori55";
  modules = {
    homeManager.enable = true;

    desktop = {
      wm = "none";

      bspwm = {
        additionalPackages = with pkgs; [
          cowsay
        ];
      };
    };
  };

  # add on first install
  system.stateVersion = "25.05";
}
