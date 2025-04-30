{pkgs}:
pkgs.writeShellScriptBin "createWorkspace" ''
  bun "/persist/nixos/modules/home-manager/scripts/createWorkspace.js"
''
