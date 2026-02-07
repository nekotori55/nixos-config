{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      config = "cd ~/.config/nixos; hx ./flake.nix";
      c = "config";
      home = "cd ~/.config/nixos/home; hx ./home.nix";
      h = "home";

      dev = "nix develop";
      flakeparts-init = "nix flake init -t github:hercules-ci/flake-parts";
    };
  };
}
