{pkgs}:
pkgs.writeShellScriptBin "createMacro" ''
  bun "/persist/nixos/modules/home-manager/scripts/createMacro.js"
''
