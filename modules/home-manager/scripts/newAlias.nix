{pkgs}:
pkgs.writeShellScriptBin "newAlias" ''
  createMacro --alias
''
