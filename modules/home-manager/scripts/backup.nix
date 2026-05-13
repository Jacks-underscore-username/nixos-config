{pkgs}:
pkgs.writeShellScriptBin "backup" ''
  sudo systemctl start code-backup.service
''
