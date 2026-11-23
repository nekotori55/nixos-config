{
  inputs,
  lib,
  self,
  ...
}:
let
  # lib shortcut
  fs = lib.fileset;
  inherit (lib) mapAttrs listToAttrs removeSuffix;
  inherit (builtins) elemAt split;
  inherit (fs) toList fileFilter;

  # workaround for:
  # "error: a string that refers to a store path cannot be appended to a path"
  # see https://discourse.nixos.org/t/what-am-i-doing-wrong-here/2517/3
  # TODO: move to lib
  toNixStorePath = path: /. + "/nix/store" + elemAt (split "/nix/store" path) 2;
  flakeRoot = toNixStorePath self.outPath;

  # make list of paths in hostsPath dir that matches hostDefinitionFileName
  # TODO: move to lib
  collectPaths = path: filename: toList (fileFilter (file: file.name == filename) path);

  hosts = listToAttrs (
    lib.map (hostFile: {
      name = baseNameOf (removeSuffix hostEntrypointName (toString hostFile));
      value = hostFile;
    }) (collectPaths hostsPath hostEntrypointName)
  );

  # settings
  hostEntrypointName = "host.nix";
  hostsPath = flakeRoot + /nixos/hosts;
  moduleEntrypointName = "module.nix";
  modulesPath = flakeRoot + /nixos/modules;
in
{
  flake.nixosConfigurations = mapAttrs (
    host: entrypoint:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        entrypoint
      ]
      ++ (collectPaths modulesPath moduleEntrypointName);

      specialArgs = {
        inherit inputs;

        hostname = host;

        # pass reference to this flake
        self = inputs.self;
      };
    }
  ) hosts;
}
