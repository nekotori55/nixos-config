{ lib, ...}:
let
  fs = lib.fileset;
  collectPaths = path: filename: fs.toList (fs.fileFilter (file: file.name == filename) path);

  modules = collectPaths ./modules "module.nix";
in
{
  imports = [
    ./profiles
  ] 
  ++ modules;
}