{pkgs}:
pkgs.writeShellScriptBin "rs" ''
  rsync -av --delete --info=progress2 --stats "$1" "$2"
''
