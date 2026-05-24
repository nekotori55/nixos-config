let
  ssh-keys = import ../keys.nix;

  inherit (ssh-keys) workstations;
  inherit (workstations)
    ash-twin
    interloper
    brittle-hollow
    ember-twin
    ;
in
{
  # Host passwords
  "passwords/ash-twin.age".publicKeys = [
    ash-twin
  ];
  "passwords/interloper.age".publicKeys = [
    interloper
    ash-twin
  ];
  "passwords/brittle-hollow.age".publicKeys = [
    brittle-hollow
    ash-twin
  ];
  "passwords/ember-twin.age".publicKeys = [
    ember-twin
    ash-twin
  ];

  # Personal services passwords
  "passwords/syncthing.age".publicKeys = workstations;
}
