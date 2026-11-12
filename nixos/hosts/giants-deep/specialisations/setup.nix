{ lib, ... }: {
  specialisation = {
    setup.configuration = {
      xui.setup-mode = lib.mkForce true;
    };
  };
}
