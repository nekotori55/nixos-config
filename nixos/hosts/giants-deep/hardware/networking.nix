{ lib, config, ... }:
{
  modules.settings.networking.static-ip = {
    enable = true;
    ip = "89.110.69.43";
    domain = "nekotori55.space";
    interface = "ens3";
  };
}
