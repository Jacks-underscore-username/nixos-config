{pkgs}:
pkgs.writeShellScriptBin "shell" ''
  if [ $# -ge 2 && "$2" == "pure" ]; then
    nix-shell "/persist/nixos/shells/$1.nix" --pure
  else
    nix-shell "/persist/nixos/shells/$1.nix"
  fi
''
