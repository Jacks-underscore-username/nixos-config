{pkgs ? import <nixpkgs> {}}:
(pkgs.buildFHSEnv {
  name = "pear";
  targetPkgs = pkgs: (with pkgs; [
    # glibc
    # glib
  ]);
  runScript = "bash";
  # export LD_LIBRARY_PATH=${pkgs.glibc}/lib
  profile = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.glib.out}/lib
  '';
}).env
