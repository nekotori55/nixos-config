let
  ssh-keys = import ../ssh-keys.nix;
in
{
  # Profile passwords
  "hp-laptop.age".publicKeys = ssh-keys.workstations;
  "teclast.age".publicKeys = ssh-keys.workstations;
  "black-box.age".publicKeys = ssh-keys.workstations;
}
