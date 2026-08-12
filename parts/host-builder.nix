{ inputs, lib, ... }:
let 
  # lib shortcuts
  fs = lib.fileset;

  # settings
  hostEntrypointFileName = "configuration.nix";
  hostsPath = ../nixos/hosts;

  modulesPath = ../nixos/modules;
  moduleName = "module.nix";

  # make list of paths in hostsPath dir that matches hostDefinitionFileName
  collectPaths = path: filename: fs.toList (fs.fileFilter (file: file.name == filename) path);

  hosts = builtins.listToAttrs (
    lib.map
      (hostFile: { 
          name = baseNameOf (lib.removeSuffix hostEntrypointFileName (toString hostFile)); 
          value = hostFile; 
      }) 
    (collectPaths hostsPath hostEntrypointFileName)
  );

  modules = collectPaths modulesPath moduleName;
in 
{
  flake.nixosConfigurations = 
    lib.mapAttrs
      (host: entrypoint: 
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            entrypoint
          ] 
          ++ modules;

          specialArgs = {
            inherit inputs;
            hostname = host;
          };
        } 
      )
      hosts;
}