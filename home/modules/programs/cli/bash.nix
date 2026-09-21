{ lib, config, osConfig, ... }:
let
  inherit (lib) mkIf ;
  cfg = config.modules.programs.cli.bash;

  tmuxCfg = osConfig.modules.programs.cli.tmux;
in
{
  options.modules.programs.cli.bash.enable = lib.mkEnableOption "bash settings management";

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      bashrcExtra = mkIf (tmuxCfg.enable && tmuxCfg.autostart)
      ''
          if [ -x "$(command -v tmux)" ] && [ -z "''${TMUX}" ]; then
              exec tmux new-session -A -s ''${USER} >/dev/null 2>&1
          fi
      '';
    };
  };
}
