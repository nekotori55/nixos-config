{ osConfig, lib, ... }:
{
  options.modules = {
    desktop = {
      enabled = lib.mkEnableOption "enable graphics";
    };
  };

  config = {
    modules = {
      desktop.enabled = !osConfig.modules.meta.headless;

      programs = {
        discord.enable = true;
        firefox.enable = true;
        kitty.enable = true;
      };
    };
  };
}
