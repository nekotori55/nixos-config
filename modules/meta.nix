{ lib, ... }:
{
  options.modules.meta = {
    # hostname = lib.mkOption {
    #   type = lib.types.singleLineStr;
    # };

    # platform = lib.mkOption {
    #   type = lib.types.singleLineStr;
    # };

    isVmVariant = lib.mkEnableOption "is this configuration running in a vm variant";
  };
}
