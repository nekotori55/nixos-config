{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      home-manager = inputs.home-manager.nixosModules.home-manager;
      nixosSystem = inputs.nixpkgs.lib.nixosSystem;
      custom-modules = ../modules;
    in
    {
      hp-laptop = nixosSystem {
        modules = [
          ./hp-laptop/configuration.nix
          home-manager
          custom-modules
        ];
      };

      teclast-laptop = nixosSystem {
        modules = [
          ./teclast-laptop/configuration.nix
          home-manager
          custom-modules
        ];
      };

      server = nixosSystem {
        modules = [
          ./server/configuration.nix
        ];
      };

    };
}
