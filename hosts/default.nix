{ inputs, lib, ... }:
{
  flake.nixosConfigurations =
    let
      nixosSystem = inputs.nixpkgs.lib.nixosSystem;

      fs = lib.fileset;
      custom-modules = fs.toList (fs.fileFilter (file: file.hasExt "nix") ../modules);

      # Inputs
      home-manager = inputs.home-manager.nixosModules.home-manager;
      agenix = inputs.agenix.nixosModules.default;
      solaar = inputs.solaar.nixosModules.default;
    in
    {
      ash-twin = nixosSystem {
        modules = [
          ./ash-twin/configuration.nix
          home-manager
          agenix
          solaar
        ]
        ++ custom-modules;
        specialArgs = { inherit inputs; };
      };

      interloper = nixosSystem {
        modules = [
          ./interloper/configuration.nix
          home-manager
          custom-modules
          agenix
        ];
      };

      brittle-hollow = nixosSystem {
        modules = [
          ./brittle-hollow/configuration.nix
          home-manager
          custom-modules
          agenix
        ];
      };

      server = nixosSystem {
        modules = [
          ./server/configuration.nix
          agenix
        ];
      };

    };
}
