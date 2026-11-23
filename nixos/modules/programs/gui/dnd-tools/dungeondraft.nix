{
  lib,
  stdenv,
  requireFile,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  zenity,
  zlib,
  krb5,
  libxrandr,
  libxi,
  libxinerama,
  libxcursor,
  libx11,
  libxext,
  libxrender,
  libxtst,
  libGL,
  alsa-lib,
  pulseaudio,
}:
let
  runtimeLibs = [
    libxcursor
    libxinerama
    libxrandr
    libx11
    libxi
    libxext
    libxrender
    libxtst
    libGL
    alsa-lib
    pulseaudio
    zlib
    krb5
  ];

  libPath = lib.makeLibraryPath runtimeLibs;
in

stdenv.mkDerivation rec {
  pname = "dungeondraft";
  version = "1.2.0.1";

  src = requireFile {
    name = "Dungeondraft-${version}-Linux64.deb";
    url = "https://dungeondraft.net/";
    hash = "sha256-UvvUCQ1RkhwBPMet/zD0JjI7DPbF4ixzOX85Fi3v/BE=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = runtimeLibs;

  runtimeDependencies = runtimeLibs;

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x "$src" .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp -R usr/share opt "$out/"

    substituteInPlace \
      "$out/share/applications/Dungeondraft.desktop" \
      --replace /opt/ "$out/opt/"

    makeWrapper "$out/opt/Dungeondraft/Dungeondraft.x86_64" "$out/bin/dungeondraft" \
      --prefix PATH : "${lib.makeBinPath [ zenity ]}" \
      --prefix LD_LIBRARY_PATH : "${libPath}"

    ln -s "$out/bin/dungeondraft" "$out/bin/Dungeondraft.x86_64"

    runHook postInstall
  '';

  meta = {
    homepage = "https://dungeondraft.net/";
    description = "Mapmaking tool for Tabletop Roleplaying Games, designed for battlemap scale";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "dungeondraft";
  };
}
