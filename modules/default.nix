{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with types;
let
  cfg = config.modules.home;
in
{
  # TODO description = "Essential stuff for every system (essential user and software stuff)";
  imports = [
    ./desktop
    ./home
  ];

  config = {
    programs.nh = {
      enable = true;
      flake = cfg.configDir + "/nixos";
    };

    environment.systemPackages = with pkgs; [
      git
      vim
      wget
    ];

    # monkey see monkey repeat
    environment.localBinInPath = true;
    environment.sessionVariables = mkOrder 10 {
      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which
      # could cause race conditions.
      XDG_BIN_HOME = cfg.binDir;
      XDG_CACHE_HOME = cfg.cacheDir;
      XDG_CONFIG_HOME = cfg.configDir;
      XDG_DATA_HOME = cfg.dataDir;
      XDG_STATE_HOME = cfg.stateDir;

      # This is not in the XDG standard. It's my jail for stubborn programs,
      # like Firefox, Steam, and LMMS.
      XDG_FAKE_HOME = cfg.fakeDir;
      XDG_DESKTOP_DIR = cfg.fakeDir;
    };
  };

}
