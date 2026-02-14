{ inputs, lib, ... }:
{
  flake.nixosConfigurations =
    let
      # Lib helpers
      inherit (lib) concatLists;
      fs = lib.fileset;

      # Collect all files from modules folder that has .nix extension
      custom-modules = fs.toList (fs.fileFilter (file: file.hasExt "nix") ../modules);

      # All inputs
      common-modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
        inputs.solaar.nixosModules.default
        inputs.zapret.nixosModules.default
      ]
      ++ custom-modules;

      # Wrapper around nixpkgs.lib.nixosSystem that includes all common-modules by default
      # (so you dont need to add inputs to every host)
      nixosSystem =
        {
          hostname,
          system,
          profile ? null,
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

      # [Main] HP-Paviliong Gaming 15 laptop WSL
      ember-twin = nixosSystem {
        hostname = "ember-twin";
        system = "x86_64-linux";
        extra-modules = [ inputs.nixos-wsl.nixosModules.wsl ];
      };

      # Teclast-F5 laptop
      interloper = nixosSystem {
        hostname = "interloper";
        system = "x86_64-linux";
        profile = "workstation";
      };

      # Old repurposed PC
      brittle-hollow = nixosSystem {
        hostname = "brittle-hollow";
        system = "x86_64-linux";
        profile = "workstation";
      };
    };
}
