{pkgs}:
pkgs.writeShellScriptBin "cycleWorkspace" ''
  bun "/persist/nixos/modules/home-manager/scripts/cycleWorkspace.js" $1
''
