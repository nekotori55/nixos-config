# make a  derivation for berkeley-mono font installation
{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "segoe-ui-linux";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "mrbvrz";
    repo = "segoe-ui-linux";
    rev = "7f6e2332d88e928d3536d79ff99347d689359652";
    sha256 = "sha256-oqS7c7BXlUMH0/4yNv1P46/YZVxBTE1RxOadDKxlXFU=";
  };

  # unpackPhase = ''
  #   runHook preUnpack
  #   ${pkgs.unzip}/bin/unzip $src

  #   runHook postUnpack
  # '';

  installPhase = ''
    runHook preInstall

    install -Dm644 font/*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
