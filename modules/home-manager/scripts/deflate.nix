{pkgs}:
pkgs.writeShellScriptBin "deflate" ''
  sudo ${pkgs.ncdu}/bin/ncdu /
''
