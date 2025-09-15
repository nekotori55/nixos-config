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
  cfg = config.modules.home;
  user = cfg.user;
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

      extraSpecialArgs = { inherit inputs; };

      sharedModules = [
        {
          xdg = {
            enable = true;
            cacheHome = mkForce cfg.cacheDir;
            configHome = mkForce cfg.configDir;
            dataHome = mkForce cfg.dataDir;
            stateHome = mkForce cfg.stateDir;
          };
        }
      ];
    };
  };
}
