{
  programs.ssh = {
    enable = true; # does not enable ssh actually, this is switch for applying settings below
    matchBlocks = {
      "nekotori55.space" = {
        user = "nekotori55";
        port = 32233;
      };
    };
  };
}
