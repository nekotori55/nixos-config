{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./disko.nix
    inputs.disko.nixosModules.disko
  ];

  # system.stateVersion = "26.05";

  users.users.nekotori55 = {
    hashedPasswordFile = config.age.secrets.brittle-hollow-password.path;
  };

  modules = {

  };

  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "ash-twin";
      sshUser = "remotebuild";
      sshKey = "/home/nekotori55/.ssh/id_ed25519";
      system = pkgs.stdenv.hostPlatform.system;
    }
  ];
}
