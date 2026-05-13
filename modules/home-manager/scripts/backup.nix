{pkgs}:
pkgs.writeShellScriptBin "backup" ''
  sudo systemctl start codeBackup.service
''
