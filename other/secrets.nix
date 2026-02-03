let
  ssh-keys = import ./ssh-keys.nix;
in
{
  # Profile passwords
  "secrets/hp-laptop.age".publicKeys = ssh-keys.workstations;
  "secrets/teclast.age".publicKeys = ssh-keys.workstations;
  "secrets/black-box.age".publicKeys = ssh-keys.workstations;
}
