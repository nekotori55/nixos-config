{ pkgs, ... }:
{
  imports = [
    ./browsers/librewolf.nix
    ./shell/git.nix
  ];

  home.packages = with pkgs;
  [
    vesktop
    firefox
    vivaldi
  ];
}
