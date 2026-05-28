{ ... }:
{
  programs.starship = {
    enable = true;
  };

  ricing-mode.files."matugen-templates/starship/config.toml".source = ./starship.toml;
  programs.matugen.templates."starship" = {
    input_path = "~/.config/matugen-templates/starship/config.toml";
    output_path = "~/.config/starship.toml";
  };
}
