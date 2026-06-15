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

  services.logind.settings.Login = {
    HandleSuspendKey = "ignore";
    HandleSuspendKeyLongPress = "suspend-then-hibernate";
    HandleLidSwitch = "suspend-then-hibernate";
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
  };

  # Gaming performance tweaks
  powerManagement.cpuFreqGovernor = "performance";
  boot.kernelParams = [ "nowatchdog" ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;

  specialisation.undocked.configuration = {
    # let nh know what specialisation is running currently
    environment.etc."specialisation".text = "undocked";

    # use ondemand governor by default
    powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";
  };
}
