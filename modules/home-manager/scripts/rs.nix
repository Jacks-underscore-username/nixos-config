{pkgs}:
pkgs.writeShellScriptBin "rs" ''
  rsync -av --delete --info=progress2 "$1" "$2"
''
