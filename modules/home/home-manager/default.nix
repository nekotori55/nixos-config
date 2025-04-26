{ lib, config, ... }:
with lib;
with builtins;
with types;
let
  user = config.modules.home.user;
in
{
  config = {
    home-manager = mkIf config.modules.home.useHomeManager {
      verbose = true;

      useGlobalPkgs = true;
      useUserPackages = true;

      backupFileExtension = "hm.old";

      # TODO make import not by name but by profile
      # Import $username home manager configuration if it exists
      users.${user.name} = mkIf (pathExists ./${user.name}) (import ./${user.name});

      sharedModules = [ { xdg.enable = true; } ];
    };
  };
}
