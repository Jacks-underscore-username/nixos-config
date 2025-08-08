{pkgs}:
pkgs.writeShellScriptBin "git_plog" ''
  bun "/persist/nixos/modules/home-manager/scripts/git_plog.js"
''
