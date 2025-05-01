{ lib, config, ... }:
with lib;
with types;
{
  options.modules.home.apps.browsers.librewolf = {
    enable = mkEnableOption "";
    profileName = mkOption {
      type = str;
      default = config.user.name;
    };

    preferences = mkOption {
      type = (attrsOf (oneOf [ bool int str ]));
      default = {};
      description = ''
      Librewolf preferences to set in <filename>user.js</filename>
      '';
    };

    # extraConfig = mkOption {
    #   type = lines;
    #   default = "";
    #   description = ''
    #   Extra lines to add to <filename>user.js</filename>
    #   '';
    # };

    # userChrome = mkOption {
    #   type = lines;
    #   default = "";
    #   description = ''
    #   CSS Styles for Librewolf's interface
    #   '';
    # };

    # userContent = mkOption {
    #   type = lines;
    #   default = "";
    #   description = ''
    #   Global CSS Styles for websites
    #   '';
    # };
  };
}
