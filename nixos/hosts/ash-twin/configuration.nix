{ lib, pkgs, ... }:
{
  imports = [
    ./hardware
    ./specialisations
    ./services
    ./modules.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";

  networking.networkmanager.enable = true;

  users.users.nekotori55.extraGroups = [ "wireshark" ];

  networking.firewall.checkReversePath = false;
  
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = [ pkgs.fcitx5-mozc pkgs.kdePackages.fcitx5-qt ];
      waylandFrontend = true;
    };
  };


  documentation = {
    dev.enable = true;
    info.enable = true;
  };

}
