let
  ssh-keys = import ../keys.nix;
in
{
  # Host passwords
  "passwords/ash-twin.age".publicKeys = [ ssh-keys.workstations.ash-twin ];
  "passwords/interloper.age".publicKeys = [ ssh-keys.workstations.interloper ];
  "passwords/brittle-hollow.age".publicKeys = [ ssh-keys.workstations.brittle-hollow ];
  "passwords/ember-twin.age".publicKeys = [ ssh-keys.workstations.ember-twin ];
}
