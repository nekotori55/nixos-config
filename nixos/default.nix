{ inputs, lib, ... }:
{
  flake.nixosConfigurations =
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
      ]
      ++ internal-modules;

      # Wrapper around nixpkgs.lib.nixosSystem that includes all common-modules by default
      # (so you dont need to add inputs to every host)
      nixosSystem =
        {
          hostname,
          system ? "x86_64-linux",
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
            [ "${hostsPath}/${hostname}/${hostFileName}" ]
            external-modules
            extra-modules
          ];
          inherit specialArgs;
        };
    in
    {
      # [Main] HP-Pavilion Gaming 15 laptop running NixOS
      ash-twin = nixosSystem {
        hostname = "ash-twin";
        profile = "workstation";
      };

      # # [Main] HP-Paviliong Gaming 15 laptop WSL
      # ember-twin = nixosSystem {
      #   hostname = "ember-twin";
      #   extra-modules = [ inputs.nixos-wsl.nixosModules.wsl ];
      # };

      # Teclast-F5 laptop
      interloper = nixosSystem {
        hostname = "interloper";
        profile = "workstation";
      };

      # Old repurposed PC
      brittle-hollow = nixosSystem {
        hostname = "brittle-hollow";
        profile = "server";
      };
    };
}
