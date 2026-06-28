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
      # ipv6.addresses = [
      #   {
      #     address = "2a13:7c00:6:28:f816:3eff:fe96:81d9";
      #     prefixLength = 64; # idk??
      #   }
      # ];
    };

    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    defaultGateway = "31.56.204.1";

    tempAddresses = "disabled";
  };
}
