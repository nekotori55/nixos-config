{
  config,
  lib,
  pkgs,
  ...
}:
let
  username = config.modules.meta.username;
in
{
  wsl.enable = true;
  wsl.defaultUser = "nekotori55";
  wsl.wslConf = {
    boot.systemd = true;
    boot.initTimeout = 40000; # 40 seconds to ensure services have time to start
  };

  system.stateVersion = "26.05";

  modules = {

  };

  # Enable flake-related commands
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Enable nix helper
  programs.nh.enable = true;
  # TODO extract path to meta option?
  programs.nh.flake = "/home/${username}/.config/nixos";
}
