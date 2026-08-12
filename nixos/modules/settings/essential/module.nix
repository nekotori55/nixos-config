{ lib, hostname, ... }:
{
  time.timeZone = lib.mkDefault "Europe/Istanbul";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  networking.hostName = lib.mkDefault hostname;
}