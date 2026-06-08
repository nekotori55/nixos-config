let
  ssh-keys = import ../keys.nix;

  inherit (ssh-keys) workstations servers;
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
  "passwords/giants-deep.age".publicKeys = [
    ash-twin
    servers.giants-deep
  ];

  # Personal services passwords
  "passwords/syncthing.age".publicKeys = workstations;

  # AWG
  "awg/awg-giants-deep.age".publicKeys = [
    servers.giants-deep
  ];
}
