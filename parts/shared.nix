{ self, ... }:
{
  flake = {
    homeManagerModules = {
      default = throw "No default module";
      ricing-mode = "${self}/shared/hm-modules/ricing-mode.nix";
    };

    nixosModules = {
      default = throw "No default module";
    };
  };
}
