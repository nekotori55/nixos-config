{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.modules.programs.kitty;
in
{
  options.modules.programs.kitty = {
    enable = lib.mkEnableOption "enable kitty";
  };

  config = mkIf (cfg.enable) {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        window_margin_width = "8 8";
      };
      keybindings = {
        "alt+t" = "new_os_window_with_cwd";
      };
    };
  };
}
