{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with types;
# let
#   username = config.modules.home.user.name;
# in
{
  # TODO description = "Essential stuff for every system (essential user and software stuff)";
  imports = [
    ./desktop
    ./home
  ];

  config = {
    # TODO is this essential?
    programs.nh.enable = true;

    environment.systemPackages = with pkgs; [
      git
      vim
      wget
    ];
  };

}
