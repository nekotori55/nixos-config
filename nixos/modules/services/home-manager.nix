{ config, lib, inputs, hostname, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption;

  # mkEnableOption' = name: mkOption {
  #   type = lib.types.bool;
  #   default = true;
  #   description = "Whether to enable ${name} (true by default)";
  # };

  homeModulesEntrypoint = "${inputs.self}/home/home.nix";

  cfg = config.modules.services.home-manager;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    (lib.mkAliasOptionModule
      [ "modules" "services" "home-manager" "users" ]
      [ "home-manager" "users" ])
  ];

  options.modules.services.home-manager = {
    enable = mkEnableOption "Enable home manager";

    # users = alias defined above
  };

  config = mkIf cfg.enable {
    home-manager = {
      verbose = true;

      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs hostname;
      };

      sharedModules = [
        homeModulesEntrypoint
        {
          home.stateVersion = config.system.stateVersion;
        }
      ];
    };
  };
}