{ config, lib, pkgs, ... }: {
  options.modules.programs.gui.wireshark = {
    enable = lib.mkEnableOption "Wireshark";
  };

  config = lib.mkIf config.modules.programs.gui.wireshark.enable {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };
}
