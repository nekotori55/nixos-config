# nekotori55 nixos configuration

## Structure
- `parts/` - flake parts parts (duh)
- `nixos/` - files related to nixos system configuration
    - `hosts/` - per-host configuration files
        - `<hostname>`
            - `configuration.nix` - config entrypoint, contains hostPlatform, stateVersion, and other host-specific settings that are too specific to put in the separate module
            - `modules.nix` - file that enables the modules needed for this host // TODO make presets using profiles
            - `hardware/` - host-specific hardware settings
            - `specialisations/` - see NixOS specialisations
    - `modules/` - toggleable features that are off by default
        - `programs/` - programs that you run manually
        - `services/` - programs that run automatically
        - `session/` - contains the things you see after starting the system whether it's a display manager, compositor or whatever else
        - `settings/` - settings (too general for specific program or service OR just a system tweak)
    - `profiles/` - toggleable groups of toggles (Currently not implemented)
- `home/` - files related to home-manager configuration
    - `modules/` - toggleable features
        - `programs/` - programs that you run manually
        - `services/` - programs that run automatically
        - `settings/` - settings (too general for specific program or service OR system tweak)
    - `profiles/` - toggleable groups of toggles (WIP)
    - `other/` - other files such as exported configs (in non .nix formats) that can't be easily nixified


## how does this config work

- `parts/host-builder.nix` searches for folders in `nixos/hosts/` that contain configuration.nix
- recursively scans `nixos/modules/` folder for files named `module.nix` and stores them in the `modules` variable
- then passes the folder name as the hostname, all modules in the `modules` variable and `configuration.nix` as a module to `lib.nixosSystem`
- home-manager is a nixos module in `nixos/modules/services/home-manager.nix`
- `home/` folder is a toggleable modules folder too, it does nothing by itself and every module has to be enabled manually (currently)

## how to try out
1. clone this repo
2. create your own host in `nixos/hosts` folder with `configuration.nix` inside, partition the disk like you normally would for nixos (see the existing hosts for example)
3. enable the needed modules (secrets will not work, so enabling them will probably make the system unusable)
3. build it like a regular nixos system using `nixos-rebuild` or `nh`

## TODO
- syncthing
- fix all warnings
