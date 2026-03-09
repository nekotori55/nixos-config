{ hostname, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      config = "cd ~/.config/nixos; hx ./flake.nix";
      configdir = "cd ~/.config/nixos";
      c = "config";
      cc = "configdir";
      home = "cd ~/.config/nixos/home; hx ./home.nix";
      hostconfig = "cd ~/.config/nixos/nixos/hosts/${hostname}; hx ./configuration.nix";
      ws = "niri msg action set-workspace-name";
      wr = "niri msg action unset-workspace-name";

      dev = "nix develop";
      flakeparts-init = "nix flake init -t github:hercules-ci/flake-parts";

      # git aliases
      gg = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      gr = "git restore --staged";
    };
  };
}
