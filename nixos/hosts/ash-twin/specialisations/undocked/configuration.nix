{ lib, ...}: {
  specialisation.undocked.configuration = {
    # let nh know what specialisation is running currently
    environment.etc."specialisation".text = "undocked";

    # use ondemand governor by default
    powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";
  };
}