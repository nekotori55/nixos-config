{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  modules = {
    home.useHomeManager = true;
    desktop = {
      wm = "hyprland";
    };

    home.apps = {
      browsers.librewolf.enable = true;
    };
  };

  networking.networkmanager.enable = true;
  #powersaveable

  environment.systemPackages = with pkgs; [
    vscode-fhs
    zed-editor
  ];

  nixpkgs.config.allowUnfree = true;

  # add on first install
  system.stateVersion = "23.05";
}
