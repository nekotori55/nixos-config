{ pkgs, ... }: 
{
  boot.kernelParams = [ "nowatchdog" ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
}