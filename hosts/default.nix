{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      home-manager = inputs.home-manager.nixosModules.home-manager;
      nixosSystem = inputs.nixpkgs.lib.nixosSystem;
    in
    {
      hp-laptop = nixosSystem {
        modules = [
          ./hp-laptop/configuration.nix
          home-manager
        ];
      };

      teclast-laptop = nixosSystem {
        # TODO
        modules = [
          ./teclast-laptop/configuration.nix
          home-manager
        ];
      };

      black-box = nixosSystem {
        # TODO
        modules = [ ];
      };

      server = nixosSystem {
        modules = [
          ./server/configuration.nix
        ];
      };

    };
}
