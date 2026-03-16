{
  lib,
  system,
  hostname,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkDefault;
  username = config.modules.meta.username;
  secrets = config.modules.secrets;
  passwordFile = config.age.secrets."${hostname}-password";
in
{
  imports = [
    ./hardware.nix
  ];

  # Set hostname
  networking.hostName = mkDefault hostname;

  # Nix settings
  nixpkgs.hostPlatform = system;
  nixpkgs.config.allowUnfree = mkDefault true;

  # Locale/Time Settings
  time.timeZone = mkDefault "Europe/Istanbul";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";

  # System packages
  environment.systemPackages = with pkgs; [
    git
    wget
    helix
  ];

  # Setup default user
  # TODO maybe move to profiles?
  users = {
    mutableUsers = mkDefault false;
    users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      # If hashed password file is not set, set password to 'changeme'
      hashedPasswordFile = mkDefault (if secrets.enabled then passwordFile.path else null);
      password = mkDefault (if secrets.enabled then null else "changeme");
    };
  };
}
