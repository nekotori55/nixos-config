{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption optional;

  cfg = config.modules.programs.cli.helix;
in
{
  options.modules.programs.cli.helix = {
    enable = mkEnableOption "Enable helix editor";
    enableNixSupport = mkEnableOption "install nil, nixd, nixfmt as language servers and configure helix";
    enableOtherLSPs = mkEnableOption "other lsp configurations";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      languages = {
        language =
          [ ]
          ++ (optional cfg.enableNixSupport [
            {
              name = "nix";
              auto-format = true;
              formatter.command = "nixfmt";
              language-servers = [
                "nixd"
                "nil"
              ];
            }
          ]);
      };

      settings = {
        editor.auto-save = {
          after-delay.enable = true;
          after-delay.timeout = 3000;
          focus-lost = true;
        };
        editor.file-explorer = {
          ignore = true;
        };
        keys.normal.space = {
          E = "file_explorer_in_current_directory";
          space = "@:cd <C-r>%<C-w><ret>";
        };
        theme = "dark-synthwave";
      };

    };


    home.packages = (
      optional cfg.enableNixSupport [
        pkgs.nil
        pkgs.nixd
        pkgs.nixfmt
      ]
    );
  };
}
