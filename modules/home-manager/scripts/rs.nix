{pkgs}:
pkgs.writeShellScriptBin "rs" ''
  rsync -av --delete --progress $1 $2
''
