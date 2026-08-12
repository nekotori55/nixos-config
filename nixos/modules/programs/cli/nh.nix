{ lib, config, ... }:
let
  username = config.modules.settings.default-user.username;
in
{
  options.modules.programs.cli.nh = {
    enable = lib.mkEnableOption "nix helper";
  };

  config = lib.mkIf config.modules.programs.cli.nh.enable {
    programs.nh = {
      enable = true;
      flake = "/home/${username}/.config/nixos";
    };
  };
}
