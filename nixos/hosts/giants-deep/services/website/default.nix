let
  website-files = ./personal;

  target-folder = "/var/www/personal";
in
{
  system.activationScripts = {
    init-site = {
      text = ''
        rm -rf ${target-folder}
        mkdir -p ${target-folder}

        # copy sites directories
        cp -r ${website-files}/* ${target-folder}
      '';
    };
  };

  services.nginx = {
    virtualHosts."nekotori55.space" = {
      enableACME = true;

      root = target-folder;
    };
  };
}
