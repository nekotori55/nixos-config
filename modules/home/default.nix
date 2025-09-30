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

      # Needed for podman shell
      # https://gist.github.com/adisbladis/187204cb772800489ee3dac4acdd9947
      subUidRanges = [
        {
          startUid = 100000;
          count = 65536;
        }
      ];
      subGidRanges = [
        {
          startGid = 100000;
          count = 65536;
        }
      ];
    };

    users.users.${username} = mkAliasDefinitions options.modules.home.user;
  };
}
