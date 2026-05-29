{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  colorgen-pkg = pkgs.writeShellScriptBin "colorgen" ''
    COLOR=`${pkgs.hyprpicker}/bin/hyprpicker -b`
    MONOCHROME=`${pkgs.matugen}/bin/matugen --json hex --dry-run color hex $COLOR $wallpaper | grep -Pzo '"source_color": {\n      "dark": "#000000",\n      "default": "#000000",\n      "light": "#000000"\n    }' --count`
    if [ $MONOCHROME == 1 ];
    then SCHEME="-t scheme-monochrome";
    else SCHEME="-t scheme-tonal-spot";
    fi;
    ${pkgs.matugen}/bin/matugen $SCHEME -r nearest --contrast 0.0 color hex $COLOR
  '';

  cfg = config.programs.matugen;
in
{
  options.programs.matugen = {
    enable = lib.mkEnableOption "";

    type = lib.mkOption {
      description = "Palette used when generating the colorschemes.";
      type = lib.types.enum [
        "scheme-content"
        "scheme-expressive"
        "scheme-fidelity"
        "scheme-fruit-salad"
        "scheme-monochrome"
        "scheme-neutral"
        "scheme-rainbow"
        "scheme-tonal-spot"
        "scheme-vibrant"
      ];
      default = "scheme-tonal-spot";
      example = "scheme-content";
    };

    variant = lib.mkOption {
      description = "Colorscheme variant.";
      type = lib.types.enum [
        "light"
        "dark"
      ];
      default = "dark";
      example = "light";
    };

    templates = lib.mkOption {
      type =
        with lib.types;
        attrsOf (submodule {
          options = {
            input_path = lib.mkOption {
              type = lib.types.nonEmptyStr;
              description = "Path to the template";
              example = "./style.css";
            };
            output_path = lib.mkOption {
              type = either str (listOf str);
              description = "Path where the generated file will be written to";
              example = "~/.config/sytle.css";
              apply = val: if lib.isList val then val else [ val ];
            };
            pre_hook = lib.mkOption {
              type = str;
              description = "Runs before the template is exported. You can use keywords here.";
              example = "echo source color {{colors.source_color.default.hex}}, source image {{image}}";
              default = "";
            };
            post_hook = lib.mkOption {
              type = str;
              description = "Runs after the template is exported. You can use keywords here.";
              example = "echo after gen {{colors.primary.default.rgb}}";
              default = "";
            };
          };
        });
      default = { };
      description = ''
        Templates that have `@{placeholders}` which will be replaced by the respective colors.
        See <https://github.com/InioX/matugen/wiki/Configuration#example-of-all-the-color-keywords> for a list of colors.
      '';
    };

  };

  config = lib.mkMerge [
    (lib.mkIf config.modules.graphics.enabled {
      home.packages = with pkgs; [
        hyprpicker
        colorgen-pkg

        matugen
      ];

      # TODO move out
      programs.matugen = {
        enable = true;
        type = "scheme-content";
        variant = "dark";
      };
    })

    (lib.mkIf config.modules.graphics.enabled {
      xdg.configFile."matugen/config.toml" =
        let
          settingsFormat = pkgs.formats.toml { };
          settingsFile = settingsFormat.generate "config.toml" {
            config = {
              version_check = false;
            };
            templates = cfg.templates;
          };
        in
        {
          source = settingsFile;
        };
    })
  ];
}
