{
  hostname,
  lib,
  config,
  ...
}:
{
  options.modules.settings.aliases = {
    enable = lib.mkEnableOption "enable aliases";
  };

  config = {
    home.shellAliases = lib.mkIf config.modules.settings.aliases.enable {
      # Config related aliases
      config = "cd ~/.config/nixos; hx ./flake.nix";
      configdir = "cd ~/.config/nixos";
      c = "config";
      cc = "configdir";
      home = "cd ~/.config/nixos/home; hx ./home.nix";
      hostconfig = "cd ~/.config/nixos/nixos/hosts/${hostname}; hx ./configuration.nix";

      # nix dev aliases
      dev = "nix develop";
      flakeparts-init = "nix flake init -t github:hercules-ci/flake-parts";

      # git aliases
      gg = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      gr = "git restore --staged";

      # config deployment aliases
      deploy = "nh os switch --target-host nekotori55.space -H giants-deep --impure";
      deploy-test = "nh os test --target-host nekotori55.space giants-deep --impure";
      deploy-boot = "nh os boot --target-host nekotori55.space giants-deep --impure";
    };
  };
}
