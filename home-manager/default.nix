{ lib, config, ... }:
with lib;
with builtins;
let
  username = config.users.defaultUser.name;
in
{
  home-manager = mkIf config.users.useHomeManager {
    verbose = true;

    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "hm.old";

    # TODO adapt for several users
    # Import $username home manager configuration if it exists
    users.${username} = mkIf (pathExists ./${username}) (import ./${username});
  };
}
