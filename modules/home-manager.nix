{
  config,
  inputs,
  ...
}:
let
  username = config.modules.meta.username;
in
{
  # TODO make a toggle
  home-manager = {
    verbose = true;

    useGlobalPkgs = true;
    useUserPackages = true;

    # Change
    backupFileExtension = "hm.old";

    users.${username} = import "${inputs.self}/home/home.nix";

    extraSpecialArgs = { inherit inputs username; };
  };
}
