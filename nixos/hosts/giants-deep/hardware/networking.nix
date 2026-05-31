{
  networking = {
    domain = "nekotori55.space";
    interfaces."ens3" = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "146.103.113.215";
          prefixLength = 24;
        }
      ];
    };

    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    defaultGateway = "146.103.113.1";
  };
}
