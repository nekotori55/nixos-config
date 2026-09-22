{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.programs.cli.tmux;
in
{
  options.modules.programs.cli.tmux = {
    enable = mkEnableOption "terminal multiplexer";
    autostart = mkEnableOption "start in bash (requires home manager bash module)";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      shortcut = "a";

      extraConfig = ''
        set -g escape-time 10
        set -g mouse on
      '';

      plugins = [ pkgs.tmuxPlugins.better-mouse-mode ];    
    };
  };
}
