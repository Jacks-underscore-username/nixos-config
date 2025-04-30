{pkgs}:
pkgs.writeShellScriptBin "completeOrphan" ''
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
  nix profile wipe-history
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
''
