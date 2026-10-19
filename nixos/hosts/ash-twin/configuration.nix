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
      addons = [
        pkgs.fcitx5-mozc
        pkgs.kdePackages.fcitx5-qt
      ];
      waylandFrontend = true;
    };
  };

  documentation = {
    dev.enable = true;
    info.enable = true;
  };

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "nekotori55";
  };

  environment.systemPackages = with pkgs; [
    qbittorrent

    btop
  ];

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;
    };
  };

  powerManagement = {
    enable = true;
  };


  # disable kde power management
  services.power-profiles-daemon.enable = false;
}
