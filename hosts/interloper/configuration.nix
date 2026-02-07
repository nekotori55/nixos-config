{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # system.stateVersion = "26.05";

  users.users.nekotori55 = {
    hashedPasswordFile = config.age.secrets.interloper-password.path;
  };

  # Custom modules
  modules = {
    gaming = {
      # enable = true;
      steam = true;
      minecraft = true;
      gamescope = true;
    };
  };
}
