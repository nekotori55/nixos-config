{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    # TODO add extensions and parameters
  };
}
