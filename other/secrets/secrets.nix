let
  ssh-keys = import ../ssh-keys.nix;
in
{
  # Host passwords
  "passwords/ash-twin.age".publicKeys = ssh-keys.workstations;
  "passwords/interloper.age".publicKeys = ssh-keys.workstations;
  "passwords/brittle-hollow.age".publicKeys = ssh-keys.workstations;
}
