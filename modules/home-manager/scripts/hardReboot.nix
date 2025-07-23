{pkgs}:
pkgs.writeShellScriptBin "hardReboot" ''
  reload laptop && sudo completeOrphan && reboot
''
