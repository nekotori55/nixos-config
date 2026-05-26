{
  pkgs,
  inputs,
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
in
{
  imports = [ inputs.matugen.nixosModules.default ];

  home.packages = with pkgs; [
    hyprpicker
    colorgen-pkg
  ];

  desktop.matugen.enable = true;

  programs.matugen = {
    enable = true;
    type = "scheme-content";
    variant = "dark";
  };
}
