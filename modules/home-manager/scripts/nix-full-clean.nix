{pkgs}:
pkgs.writeShellScriptBin "nix-full-clean" ''
  sudo nix-collect-garbage -d && \
  home-manager expire-generations -d && \
  nix store gc && \
  sudo nix store optimize && \
  sudo nix profile wipe-history && \
  home-manager remove-generations old && \
  nix-store --verify --check-contents --repair && \
  reboot
''
