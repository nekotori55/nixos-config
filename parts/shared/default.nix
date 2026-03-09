{ self, ... }:
let
  sharedModulesPath = ./.;
in
{
  flake = {
    homeManagerModules = {
      default = throw "No default module";
      ricing-mode = "${sharedModulesPath}/hm-modules/ricing-mode.nix";
    };

    nixosModules = {
      default = throw "No default module";
    };
  };
}
