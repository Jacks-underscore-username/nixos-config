{pkgs}:
pkgs.writeShellScriptBin "shell" ''
  nix-shell "/persist/nixos/shells/$\{$1}.nix"
''
