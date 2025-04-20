{ config, pkgs, ... }:
{
  # TODO description = "Essential stuff for every system (essential user and software stuff)";
  imports = [
    ./desktop
  ];

  # TODO support several users
  users.users = {
    ${config.users.defaultUser.name} = {
      # name = ;
      initialPassword = "123";
      isNormalUser = true;
      uid = 1000;
    };
  };

  # TODO is this essential?
  programs.nh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];
}
