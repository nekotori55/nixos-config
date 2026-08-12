# nekotori55 nixos configuration

## Structure
- `parts/` - flake parts parts (duh)
- `nixos/` - files related to nixos system configuration
    - `hosts/` - per-host configuration files
    - `modules/` - togglable features
        - `programs/` - programs that you run manually and their settings
        - `services/` - programs that runs automatically
        - `settings/` - settings (too general for specific program or service OR system tweak)
    - `profiles/` - togglable groups of toggles
- `home/` - files related to home-manager configuration
    - `modules/` - togglable features
        - `programs/` - programs that you run manually and their settings
        - `services/` - programs that runs automatically
        - `settings/` - settings (too general for specific program or service OR system tweak)
    - `profiles/` - togglable groups of toggles
    - `other/` - other files like exported config that can't be or too unconvinient to nixify


## how does this config work

- host defined in flake part in `filename` 
- imports host-specific nixos config defined in `nixos/hosts/<hostname>`
- that imports all modules and profiles (and toggles needed profiles and modules switches on)