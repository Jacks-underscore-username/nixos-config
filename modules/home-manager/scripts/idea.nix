{pkgs}:
pkgs.writeShellScriptBin "idea" ''
  idea-community "$(pwd)"
''
