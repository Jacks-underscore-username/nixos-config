{pkgs}:
pkgs.writeShellScriptBin "nix-find" ''
  nix eval nixpkgs#"$1".outPath
''
