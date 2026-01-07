{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.android-dev = {
    enable = mkEnableOption ''Enable AndroidStudio and ADB'';
  };

  config = mkIf config.modules.android-dev.enable {
    # Enable ADB
    programs.adb.enable = true;

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
