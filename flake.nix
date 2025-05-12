{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        # TODO turn this into function that searches hosts/ path
        green = nixpkgs.lib.nixosSystem {
          modules = [
            ./.
            ./hosts/green

            # TODO include only when users.useHomeManager = true;
            home-manager.nixosModules.home-manager
          ];
        };
        work-vm = nixpkgs.lib.nixosSystem {
	   modules = [ ./. ./hosts/work-vm home-manager.nixosModules.home-manager ];
        };
      };

      devShells."x86_64-linux".default =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
          };
        in
        pkgs.mkShell {
          packages = with pkgs; [
            nixd
            nixfmt-rfc-style
            nil
          ];
        };
    };
}
