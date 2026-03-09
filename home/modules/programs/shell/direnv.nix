{ lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.git = mkIf config.programs.direnv.enable {
    ignores = [
      ".direnv/"
      ".envrc"
    ];
  };
}
