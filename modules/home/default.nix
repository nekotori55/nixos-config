{
  config,
  options,
  lib,
  ...
}:
let
  username = config.modules.home.user.name;
in
with lib;
{
  imports = [
    ./xdg.nix
  ];

  config = {
    modules.home.user = {
      name = "nekotori55";
      initialPassword = "123";
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "wheel" ];
      home = "/home/${username}";
    };

    users.users.${username} = mkAliasDefinitions options.modules.home.user;
  };
}
