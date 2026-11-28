{ lib, ... }: {
  specialisation.undocked.configuration = {
    # let nh know what specialisation is running currently
    environment.etc."specialisation".text = "undocked";

    # use ondemand governor by default
    powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

    services.displayManager.autoLogin.enable = lib.mkForce false;

    environment.sessionVariables = {
      "KWIN_DRM_DEVICES" = lib.mkForce "/dev/dri/card2";
    };

    programs.gamemode.enable = lib.mkForce false;

    modules = {
      services = {
        # solaar = lib.mkForce false;
      };
    };
  };
}
