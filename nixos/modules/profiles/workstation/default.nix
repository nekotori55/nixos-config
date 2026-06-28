{
  lib,
  config,
  pkgs,
  inputs,
  system,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
  username = config.modules.meta.username;

in
{
  imports = [
    ./modules.nix
    ./virtualisation.nix
    ./graphics.nix
    ./hardware.nix
  ];

  config = mkIf (config.modules.profiles.profile == "workstation") {
    # Nix
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    programs.nh = {
      # Enable nix helper
      enable = mkDefault true;
      # TODO extract path to meta option?
      flake = mkDefault "/home/${username}/.config/nixos";
    };

    # Enable network manager
    networking.networkmanager.enable = mkDefault true;

    services.displayManager.autoLogin = {
      enable = true;
      user = username;
    };
  };
}
