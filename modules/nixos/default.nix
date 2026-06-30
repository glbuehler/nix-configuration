{ lib, ... }:

let
  dirs = lib.attrNames (builtins.readDir ./.);

  imports = builtins.concatMap (
    name:
    let
      path = ./. + "/${name}";
    in
    if
      (builtins.readDir ./.)."${name}" == "directory" && builtins.pathExists (path + "/default.nix")
    then
      [ path ]
    else
      [ ]
  ) dirs;
in
{
  inherit imports;
}
