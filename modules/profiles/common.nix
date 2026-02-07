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
  modules = {
    ssh.enableSshd = true;
  };

  # Set hostname
  networking.hostName = mkDefault hostname;

  # Nix settings
  nixpkgs.hostPlatform = system;
  nixpkgs.config.allowUnfree = mkDefault true;

  # Enable redistributable firmware by default
  hardware.enableRedistributableFirmware = mkDefault true;

  # Enable blueman if bluetooth is enabled
  services.blueman.enable = mkDefault config.hardware.bluetooth.enable;

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
  users = {
    mutableUsers = mkDefault false;
    users.${username} = rec {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      # If hashed password file is not set, set password to 'changeme'
      hashedPasswordFile = mkDefault (if secrets.enabled then passwordFile.path else null);
      password = mkDefault (if (hashedPasswordFile == null) then "changeme" else null);
    };
  };
}
