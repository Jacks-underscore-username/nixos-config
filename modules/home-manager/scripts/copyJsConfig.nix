{pkgs}:
pkgs.writeShellScriptBin "copyJsConfig" ''
  bun "/persist/nixos/modules/home-manager/scripts/copyJsConfig.js"
''