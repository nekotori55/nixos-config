{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";

  users.defaultUser.name = "nekotori55";
  users.useHomeManager = true;
  desktop = {
    wm = "bspwm";

    bspwm = {
      enable = true;
      # configFilePath = "${pkgs.bspwm}/share/doc/bspwm/examples/bspwmrc";
      # sxhkd.configFilePath = "${pkgs.bspwm}/share/doc/bspwm/examples/sxhkdrc";

      additionalPackages = with pkgs; [
        kitty
        cowsay
      ];
    };
  };

  # add on first install
  system.stateVersion = "25.05";
}
