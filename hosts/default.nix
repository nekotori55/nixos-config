{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      # Inputs shorthands
      home-manager = inputs.home-manager.nixosModules.home-manager;
      agenix = inputs.agenix.nixosModules.default;

      nixosSystem = inputs.nixpkgs.lib.nixosSystem;
      custom-modules = ../modules;
    in
    {
      hp-laptop = nixosSystem {
        modules = [
          ./hp-laptop/configuration.nix
          home-manager
          custom-modules
          agenix
        ];
        specialArgs = { inherit inputs; };
      };

      teclast-laptop = nixosSystem {
        modules = [
          ./teclast-laptop/configuration.nix
          home-manager
          custom-modules
          agenix
        ];
      };

      black-box = nixosSystem {
        modules = [
          ./black-box/configuration.nix
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
