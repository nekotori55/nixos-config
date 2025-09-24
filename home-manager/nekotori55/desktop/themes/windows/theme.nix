{
  pkgs,
  osConfig,
  lib,
  ...
}:
let
  themeEnabled = osConfig.modules.desktop.theme == "windows";
  segoe-ui-linux = pkgs.callPackage ./segoe-ui.nix { inherit pkgs; };
in
{
  config = lib.mkIf themeEnabled {
    home.packages = with pkgs; [
      fuzzel
      segoe-ui-linux
    ];

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

    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };

    xdg.configFile."waybar" = {
      source = ./waybar;
      recursive = true;
    };
  };
}
