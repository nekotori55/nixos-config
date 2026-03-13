{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware
    ./modules.nix
  ];

  # TODO
  # 1. make on-the-go/single-display specialisation

  # NixOS system
  system.stateVersion = "26.05";

  # For dualbooting
  time.hardwareClockInLocalTime = false;

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

  virtualisation.vmVariant = {
    modules.secrets.enabled = false;
  };

  # VM-HOST
  virtualisation.virtualbox.host = {
    enable = true;
  };

  services.logind.settings.Login = {
    LidSwitch = "suspend-then-hibernate";
    PowerKey = "suspend-then-hibernate";
    PowerKeyLongPress = "poweroff";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec = 30m
    SuspendState=mem
  '';
}
