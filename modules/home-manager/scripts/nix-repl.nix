{pkgs}:
pkgs.writeShellScriptBin "nix-repl" ''
  nix repl --expr 'import <nixpkgs>{}'
''
