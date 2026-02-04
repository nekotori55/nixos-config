{ inputs, lib, ... }:
{
  flake.nixosConfigurations =
    let
      # Lib helpers
      fs = lib.fileset;
      inherit (lib) singleton concatLists;

      # Collect all files from modules folder that has .nix extension
      custom-modules = fs.toList (fs.fileFilter (file: file.hasExt "nix") ../modules);

      # default.nix from profiles folder
      profiles = "${inputs.self}/profiles";

      # All inputs
      common-modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
        inputs.solaar.nixosModules.default

        profiles
      ]
      ++ custom-modules;

      # Wrapper around nixpkgs.lib.nixosSystem that includes all common-modules by default
      # (so you dont need to add inputs to every host)
      nixosSystem =
        {
          hostname,
          system,
          profile,
          extra-modules ? [ ],
          specialArgs ? {
            inherit
              inputs
              hostname
              system
              profile
              ;
          },
        }:
        inputs.nixpkgs.lib.nixosSystem {
          modules = concatLists [
            [ "${inputs.self}/hosts/${hostname}/configuration.nix" ]
            common-modules
            extra-modules
          ];
          inherit specialArgs;
        };
    in
    {
      # [Main] HP-Pavilion Gaming 15 laptop running NixOS
      ash-twin = nixosSystem {
        hostname = "ash-twin";
        system = "x86_64-linux";
        profile = "workstation";
      };

      # Teclast-F5 laptop
      # interloper = nixosSystem {
      # hostname = "interloper";
      # };

      # Old repurposed PC
      # brittle-hollow = nixosSystem {
      # hostname = "brittle-hollow";
      # };
    };
}
