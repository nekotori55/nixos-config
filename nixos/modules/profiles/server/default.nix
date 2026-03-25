{ ... }:
{
  services.openssh = {
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.timesyncd.enable = true;
}
