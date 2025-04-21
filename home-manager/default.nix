{
  lib,
  config,
  inputs,
  ...
}:
with lib;
with builtins;
with types;
let
  username = config.user.name;
in
{
  # TODO: maybe move home-manager to modules
  options = {
    modules.homeManager.enable = mkEnableOption false;
  };

  config = {
    home-manager = mkIf config.modules.homeManager.enable {
      verbose = true;

      useGlobalPkgs = true;
      useUserPackages = true;

      backupFileExtension = "hm.old";

      # TODO adapt for several users
      # Import $username home manager configuration if it exists
      users.${username} = mkIf (pathExists ./${username}) (import ./${username});
    };
  };
}
