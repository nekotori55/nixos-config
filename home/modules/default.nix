{ ... }:
{
  imports = [
    ./ricing-mode.nix
  ];

  ricing-mode.files = {
    "test/test.txt" = {
      text = "test is successfull";
    };
    "amogus/corp.conf" = {
      text = ''aboba'';
    };
  };
}
