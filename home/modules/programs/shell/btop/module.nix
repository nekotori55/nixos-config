{ ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "matugen";
      theme_background = false;
    };
  };

  ricing-mode.files."matugen-templates/btop/btop.theme".source = ./btop.theme;
  programs.matugen.templates."btop" = {
    input_path = "~/.config/matugen-templates/btop/btop.theme";
    output_path = "~/.config/btop/themes/matugen.theme";
    post_hook = "pkill -USR2 btop || true";
  };
}
