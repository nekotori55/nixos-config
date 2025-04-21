{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with types;
{
  # TODO description = "Essential stuff for every system (essential user and software stuff)";
  imports = [
    ./desktop
    ./xdg.nix
    ./home.nix
  ];

  options = {
    user = mkOption {
      type = attrs;
      default = {
        name = "";
      };
    };
  };

  config = {
    user = {
      initialPassword = "123";
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" ];
      home = "/home/${config.user.name}";
    };
    users.users.${config.user.name} = mkAliasDefinitions options.user;

    # TODO is this essential?
    programs.nh.enable = true;

    environment.systemPackages = with pkgs; [
      git
      vim
      wget
    ];
  };

}
