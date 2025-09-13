{ pkgs, ... }:
{
  imports = [
    ./browsers/librewolf.nix
    ./shell/git.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    vesktop
    firefox
    vivaldi
  ];
}
