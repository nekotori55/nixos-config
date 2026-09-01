{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption;

  cfg = config.modules.programs.gui.ide;

in
{
  options.modules.programs.gui.ide = {
    enable = mkEnableOption "IDE's";
    vscode.enable = mkEnableOption "vscode-fhs";
    jetbrains = {
      idea.enable = mkEnableOption "IDEA ide";
      pycharm.enable = mkEnableOption "Pycharm";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      [ ]
      ++ (lib.optional cfg.vscode.enable pkgs.vscode-fhs)
      ++ (lib.optional cfg.jetbrains.idea.enable pkgs.jetbrains.idea)
      ++ (lib.optional cfg.jetbrains.pycharm.enable pkgs.jetbrains.pycharm)
      ;
  };
}
