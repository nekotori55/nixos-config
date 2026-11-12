{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkDefault;
in
{
  options.modules.settings.nix = {
    enable = mkEnableOption "Convinient nix defaults";
  };

  # a lot of stuff taken from and explained here
  # https://github.com/NotAShelf/nyx/blob/d407b4d6e5ab7f60350af61a3d73a62a5e9ac660/modules/core/common/system/nix/module.nix#L210
  config = mkIf config.modules.settings.nix.enable {
    nixpkgs.config.allowUnfree = mkDefault true;
    nix =
      let
        mappedRegistry = lib.pipe inputs [
          (lib.filterAttrs (_: lib.isType "flake"))
          (lib.mapAttrs (_: flake: { inherit flake; }))
          (flakes: flakes // { nixpkgs.flake = inputs.nixpkgs; })
        ];
      in
      {
        registry = mappedRegistry // {
          default-flake = mappedRegistry.nixpkgs;
        };
        nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

        package = pkgs.lix;

        # let me use pc on nix build
        daemonCPUSchedPolicy = "idle";
        daemonIOSchedClass = "idle";
        daemonIOSchedPriority = 7;

        # Automatically optimize nix store my removing hard links
        # do it after the gc.
        optimise = {
          automatic = true;
          dates = [ "04:00" ];
        };

        settings = {

          experimental-features = [
            "nix-command"
            "flakes"
          ];

          trusted-users = [
            "root"
            "@wheel"
            "nix-builder"
          ];

          warn-dirty = false;

          builders-use-substitutes = true;

          log-lines = 30;

          max-jobs = "auto";

          min-free = "${toString (5 * 1024 * 1024 * 1024)}";
          max-free = "${toString (10 * 1024 * 1024 * 1024)}";
          auto-optimise-store = true;

          substituters = [
            "https://nix-community.cachix.org"
            "https://nixpkgs-unfree.cachix.org"
          ];

          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
          ];
        };
      };

  };
}
