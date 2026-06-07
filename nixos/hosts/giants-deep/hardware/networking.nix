{
  networking = {
    domain = "nekotori55.space";
    interfaces."ens3" = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "31.56.204.57";
          prefixLength = 24;
        }
      ];
    };

    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    defaultGateway = "31.56.204.1";
  };
}
