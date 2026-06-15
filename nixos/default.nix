{ inputs, lib, ... }:
let
  # Helpers
  inherit (lib) concatLists;
  fs = lib.fileset;

  modulesPath = ./modules;
  moduleFileName = "module.nix";
  hostsPath = ./hosts;
  hostFileName = "configuration.nix";

  # Modules from this flake
  # Collecting all files from modules folder that has name module.nix
  internal-modules = fs.toList (fs.fileFilter (file: file.name == moduleFileName) modulesPath);

  # Modules from inputs
  external-modules = [
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    inputs.solaar.nixosModules.default
    inputs.zapret.nixosModules.default
    inputs.disko.nixosModules.disko
  ]
  ++ internal-modules;

  # Wrapper around nixpkgs.lib.nixosSystem that includes all common-modules by default
  # (so you dont need to add inputs to every host)
  nixosSystem =
    {
      hostname ? "nohostname",
      system ? "x86_64-linux",
      profile ? null,
      no-modules ? false,
      host-file-path ? "${hostsPath}/${hostname}/${hostFileName}",
      extra-modules ? [ ],
      specialArgs ? {
        inherit
          inputs
          hostname
          system
          profile
          builders
          ;
      },
      extraArgs ? { },
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = concatLists [
        [ host-file-path ]
        (lib.optionals (!no-modules) external-modules)
        (lib.optionals (!no-modules) extra-modules)
      ];
      specialArgs = (specialArgs // extraArgs);
    };

  builders = lib.mapAttrsToList (n: v: v.hostname) (
    lib.filterAttrs (n: v: (builtins.hasAttr "is-builder" v) && (v.is-builder)) hosts
  );

  hosts = {
    # [Main] HP-Pavilion Gaming 15 laptop running NixOS
    ash-twin = {
      hostname = "ash-twin";
      profile = "workstation";
      is-builder = true;
    };

    # # [Main] HP-Paviliong Gaming 15 laptop WSL
    # ember-twin = nixosSystem {
    #   hostname = "ember-twin";
    #   extra-modules = [ inputs.nixos-wsl.nixosModules.wsl ];
    # };

    # Teclast-F5 laptop
    interloper = {
      hostname = "interloper";
      profile = "workstation";
    };

    # Old repurposed PC (dead)
    # brittle-hollow = {
    #   hostname = "brittle-hollow";
    #   profile = "server";
    # };

    giants-deep = {
      hostname = "giants-deep";
      profile = "server";
    };
  };
in
{
  flake.nixosConfigurations = (lib.mapAttrs (n: v: nixosSystem v) hosts);
}
