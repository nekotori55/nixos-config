{ ... }:
let
  keys = import ../other/ssh-keys.nix;
in
{
  users.users.nekotori55.openssh.authorizedKeys.keys = [
    keys.hp-laptop-key
    keys.pixel-key
  ];

}
