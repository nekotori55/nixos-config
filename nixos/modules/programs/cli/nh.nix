{ lib, config, ... }:
let
  username = config.modules.settings.default-user.username;

  cfg = config.modules.programs.cli.nh;
in
{
  options.modules.programs.cli.nh = {
    enable = lib.mkEnableOption "nix helper";
    clean = lib.mkEnableOption "running nh clean weekly";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = lib.mkDefault "/home/${username}/.config/nixos";
      clean = {
        enable = cfg.clean;
        dates = lib.mkDefault "weekly";
        extraArgs = "--keep 5 --keep-since 3d --keep-one --optimise";
      };
    };
  };
}
