{ lib, pkgs, ... }:
{
  imports = [
    ./desktop-environment.nix
  ];
  # System
  home.stateVersion = "25.05";

  # Essentials
  programs.git = {
    enable = true;
    userEmail = "nekotori55@gmail.com";
    userName = "nekotori55";
    lfs.enable = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
    ];
  };
}
