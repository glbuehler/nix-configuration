{ lib, ... }:
let
  all_paths = lib.filesystem.listFilesRecursive ./.;
  paths = builtins.filter (
    p: p != ./. + ("/" + baseNameOf __curPos.file) && lib.strings.hasSuffix ".nix" "${p}"
  ) all_paths;
in
{
  imports = paths;
}
