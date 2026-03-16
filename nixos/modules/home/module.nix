{
  config,
  lib,
  inputs,
  pkgs,
  hostname,
  ...
}:
let
  inherit (lib) mkIf mkOption mkEnableOption;

  cfg = config.modules.home;
  username = config.modules.meta.username;
in
{
  options.modules.home = {
    enableHomeManager = mkEnableOption "Whether to enable home manager or not";
  };

  # TODO make a toggle
  config = mkIf cfg.enableHomeManager {
    home-manager = {
      verbose = true;

      useGlobalPkgs = true;
      useUserPackages = true;

      # backupCommand = "trash";
      backupCommand = "${pkgs.trash-cli}/bin/trash";

      users.${username} = import "${inputs.self}/home/home.nix";

      extraSpecialArgs = { inherit inputs username hostname; };

      sharedModules = [ inputs.self.homeManagerModules.ricing-mode ];
    };
  };
}
