{pkgs}:
pkgs.writeShellScriptBin "backup" ''
  sudo code-backup
''
