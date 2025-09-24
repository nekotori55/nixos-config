{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  # themeEnabled = osConfig.modules.desktop.theme == "default";
in
{
  config = lib.mkIf (osConfig.modules.desktop.theme == "default") {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };

    programs.fuzzel = {
      enable = true;
      settings =
        let
          themeSrc = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "fuzzel";
            rev = "0af0e26901b60ada4b20522df739f032797b07c3";
            sha256 = "sha256-XpItMGsYq4XvLT+7OJ9YRILfd/9RG1GMuO6J4hSGepg=";
          };
        in
        {
          main.include = toString "${themeSrc}/themes/catppuccin-mocha/green.ini";
        };
    };

    home.pointerCursor = {
      enable = true;
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      hyprcursor.enable = true;
      hyprcursor.size = 24;
      size = 24;
      # gtk.enable = true;
      # x11 = {
      # enable = true;
      # defaultCursor = "phinger-cursors-light";
      # };
    };

    xdg.configFile."waybar" = {
      source = ./waybar;
      recursive = true;
    };
  };
}
