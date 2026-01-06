{ pkgs, ... }:
{
  # Enable ADB
  programs.adb.enable = true;

  # Setup additional groups for unprivileged access
  users.users.nekotori55.extraGroups = [
    "adbusers"
    "kvm"
  ];

  # Install Android Studio and SDK
  # environment.systemPackages = with pkgs; [
  # android-studio-full
  # ];

  # Accept license
  # nixpkgs.config.android_sdk.accept_license = true;
}
