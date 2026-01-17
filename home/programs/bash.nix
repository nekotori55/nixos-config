{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      config = "cd ~/.config/nixos; hx ./flake.nix";
      conf = "config";
      home = "cd ~/.config/nixos/home; hx ./home.nix";
      qs = "cd ~/.config/quickshell; hx ./shell.qml";

      dev = "nix develop";
      flakeparts-init = "nix flake init -t github:hercules-ci/flake-parts";
    };
  };
}
