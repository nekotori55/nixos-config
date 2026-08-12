{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption;

  cfg = config.modules.programs.gui.social;

  discord-with-vencord = (
    pkgs.discord.override {
      withVencord = true;
    }
  );
in
{
  options.modules.programs.gui.social = {
    enable = mkEnableOption "Social";
    telegram.enable = mkEnableOption "Telegram-Desktop";
    discord.enable = mkEnableOption "discord";
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      [ ]
      ++ (lib.optional cfg.telegram.enable pkgs.telegram-desktop)
      ++ (lib.optional cfg.discord.enable discord-with-vencord);
  };
}
