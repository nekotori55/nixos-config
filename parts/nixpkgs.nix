{ inputs, config, ... }:
{
  perSystem =
    { system, ... }:
    {
      legacyPackages = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      _module.args.pkgs = config.legacyPackages;
    };
}
