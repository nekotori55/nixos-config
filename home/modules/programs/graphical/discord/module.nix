{ pkgs, ... }:
let
  discord-with-vencord = (
    pkgs.discord.override {
      withVencord = true;
    }
  );
in
{
  home.packages = with pkgs; [
    vesktop
    discord-with-vencord
  ];
  ricing-mode.files."matugen-templates/discord/theme.css".source = ./discord.css;
  programs.matugen.templates = {
    "vesktop" = {
      input_path = "~/.config/matugen-templates/discord/theme.css";
      output_path = "~/.config/vesktop/themes/matugen.css";
    };
    "vencord" = {
      input_path = "~/.config/matugen-templates/discord/theme.css";
      output_path = "~/.config/Vencord/themes/matugen.css";
    };
  };
}
