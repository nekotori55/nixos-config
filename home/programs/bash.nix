{ hostname, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      config = "cd ~/.config/nixos; hx ./flake.nix";
      c = "config";
      home = "cd ~/.config/nixos/home; hx ./home.nix";
      hostconfig = "cd ~/.config/nixos/hosts/${hostname}; hx ./configuration.nix";
      # todo = "fasole ~/notes/TODO.md";
      mode = ''MODE=`cat ~/.config/mode.conf`; if [ ''${MODE:-dark} == "dark" ] ; then echo "light" > ~/.config/mode.conf ; else echo "dark" > ~/.config/mode.conf ; fi ; waypaper --restore; echo $MODE '';

      dev = "nix develop";
      flakeparts-init = "nix flake init -t github:hercules-ci/flake-parts";
    };
  };
}
