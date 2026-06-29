{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.programs.discord;

  discord-with-vencord = (
    pkgs.discord.override {
      withVencord = true;
    }
  );
in
{
  options.modules.programs.discord.enable = mkEnableOption "enable discord";

  config = lib.mkIf cfg.enable {
    home.packages = [
      discord-with-vencord
    ];
  };
}
