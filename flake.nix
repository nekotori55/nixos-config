{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    jerry.url = "github:justchokingaround/jerry/main";
    jerry.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-generators,
      jerry,
      ...
    }:
    {
      # nixosModules.myFormats =
      #   { config, ... }:
      #   {
      #     imports = [
      #       nixos-generators.nixosModules.all-formats
      #     ];

      #     nixpkgs.hostPlatform = "x86_64-linux";

      #     # customize an existing format
      #     formatConfigs.vmware =
      #       { config, ... }:
      #       {
      #         services.openssh.enable = true;
      #       };

      #     # define a new format
      #     formatConfigs.my-custom-format =
      #       { config, modulesPath, ... }:
      #       {
      #         imports = [ "${toString modulesPath}/installer/cd-dvd/installation-cd-base.nix" ];
      #         formatAttr = "isoImage";
      #         fileExtension = ".iso";
      #         networking.wireless.networks = {
      #           # ...
      #         };
      #       };
      #   };

      nixosConfigurations = {
        # TODO turn this into function that searches hosts/ path
        green = nixpkgs.lib.nixosSystem {
          modules = [
            ./.
            ./hosts/green

            # TODO include only when users.useHomeManager = true;
            home-manager.nixosModules.home-manager
          ];

          specialArgs = { inherit inputs; };
        };

        work-vm = nixpkgs.lib.nixosSystem {
          modules = [
            ./.
            ./hosts/work-vm
            home-manager.nixosModules.home-manager
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/server
          ];
        };

        pancake = nixpkgs.lib.nixosSystem {
          modules = [
            ./.
            ./hosts/pancake
            home-manager.nixosModules.home-manager
          ];

          specialArgs = { inherit inputs; };
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
