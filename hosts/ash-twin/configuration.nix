{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  # TODO
  # 1. make on-the-go/single-display specialisation

  # NixOS system
  system.stateVersion = "26.05";

  # Wake on Lan
  networking.interfaces = lib.mkIf (!config.modules.meta.isVmVariant) {
    eno1.wakeOnLan.enable = true;
  };
  networking.firewall.allowedUDPPorts = [ 9 ];

  # For dualbooting
  time.hardwareClockInLocalTime = false;

  # Change password
  users.users.nekotori55 = {
    password = null;
    hashedPasswordFile = config.age.secrets.ash-twin-password.path;
  };

  # Custom modules
  modules = {
    gaming = {
      enable = true;
      steam = true;
      minecraft = true;
      gamescope = true;
      osu = true;
    };
    android-dev.enable = true;
  };

  # Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      samsung-unified-linux-driver
    ];
  };
  environment.systemPackages = with pkgs; [
    system-config-printer
  ];

  # VM-HOST
  virtualisation.virtualbox.host = {
    enable = true;
  };
}
