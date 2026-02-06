{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.android-dev;
in
{
  options.modules.android-dev = {
    enable = mkEnableOption "Enable AndroidStudio and ADB";
  };

  config = mkIf cfg.enable {
    # Setup additional groups for unprivileged access
    # TODO abstract
    users.users.nekotori55.extraGroups = [
      "adbusers"
      "kvm"
    ];

    # Install Android Studio and SDK
    environment.systemPackages = with pkgs; [
      android-studio
    ];

    # Accept license
    # nixpkgs.config.android_sdk.accept_license = true;
  };
}
