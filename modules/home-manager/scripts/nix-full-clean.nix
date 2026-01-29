{pkgs}:
pkgs.writeShellScriptBin "nix-full-clean" ''
  sudo nix-collect-garbage -d &&
  nix store gc &&
  sudo nix store optimise &&
  sudo nix profile wipe-history &&
  nix-store --verify --check-contents --repair &&
  reboot
''
