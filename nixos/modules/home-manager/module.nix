{
  config,
  inputs,
  pkgs,
  hostname,
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

    # backupCommand = "trash";
    backupCommand = "${pkgs.trash-cli}/bin/trash";

    users.${username} = import "${inputs.self}/home/home.nix";

    extraSpecialArgs = { inherit inputs username hostname; };

    sharedModules = [ inputs.self.homeManagerModules.ricing-mode ];
  };
}
