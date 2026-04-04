{
  lib,
  pkgs,
  ...
}: let
  runtimeLibs = import ../../lib/runtimeLibs.nix {inherit pkgs;};
in {
  programs.nix-ld = {
    enable = true;
    libraries = runtimeLibs;
  };

  environment.variables.LD_LIBRARY_PATH = lib.mkForce (lib.makeLibraryPath runtimeLibs);

  environment.systemPackages = runtimeLibs;
}
