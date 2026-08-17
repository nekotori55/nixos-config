{ pkgs, config, ... }:
{
  imports = [
    ./hardware
    ./modules.nix
    ./services
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";


  # TEST
  # modules.programs.cli.backuper.paths = [
    # "/home/nekotori55/backuper-test"
  # ];

  environment.systemPackages = with pkgs; [
    restic
  ];

  # users.users."restic" = {
  #   isSystemUser = true;
  #   group = "restic";
  #   openssh.authorizedKeys.keys = config.modules.services.ssh.workstationKeys;
  # };

  # users.groups.restic = {};

} 
