{pkgs}:
pkgs.writeShellScriptBin "createAlias" ''
  createMacro --alias
''
