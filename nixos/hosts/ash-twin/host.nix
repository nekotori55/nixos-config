{ lib, pkgs, ... }:
{
  imports = [
    ./hardware
    ./specialisations
    ./services
    ./modules.nix
    ./modules
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";

  # Fixes networking
  networking.networkmanager.enable = true;

  users.users.nekotori55.extraGroups = [
    "wireshark"
    "kvm"
  ];

  # Japanese Keyboard
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

  # Replace power-profiles daemon with TLP
  # to be able to switch to battery saver mode using terminal
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
  powerManagement.enable = true;
  # disable kde power management
  services.power-profiles-daemon.enable = false;

  # Some packages
  environment.systemPackages = with pkgs; [
    qbittorrent
    btop
  ];
}
