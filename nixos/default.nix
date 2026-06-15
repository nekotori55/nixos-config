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

  # Wrapper around nixpkgs.lib.nixosSystem that includes all common-modules by default
  # (so you dont need to add inputs to every host)
  nixosSystem =
    {
      hostname ? "nohostname",
      system ? "x86_64-linux",
      profile ? null,
      host-file-path ? "${hostsPath}/${hostname}/${hostFileName}",
      extra-modules ? [ ],
      specialArgs ? { },
      ...
    }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = concatLists [
        [ host-file-path ]
        internal-modules
        extra-modules
      ];
      specialArgs = (
        {
          inherit
            inputs
            hostname
            system
            profile
            ;
        }
        // specialArgs
      );
    };

  hosts = import ./hosts.nix;
in
{
  flake.nixosConfigurations = (lib.mapAttrs (n: v: nixosSystem v) hosts);
}
