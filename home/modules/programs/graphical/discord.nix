{
  pkgs,
  config,
  lib,
  ...
}:
let
  discord-with-vencord = (
    pkgs.discord.override {
      withVencord = true;
    }
  );
in
{
  options.modules.programs.discord.enable = lib.mkEnableOption "enable discord";

  config = lib.mkIf config.modules.programs.discord.enable {
    home.packages = [
      discord-with-vencord
    ];
  };
}
