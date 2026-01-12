{
  osConfig,
  lib,
  inputs,
  ...
}:
{
  home-manager = {
    verbose = true;

    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "hm.old";

    users.nekotori55 = import ../home/home.nix;

    # modules = [ ];

    extraSpecialArgs = { inherit inputs; };
  };
}
