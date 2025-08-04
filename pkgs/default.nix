# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  keet = pkgs.callPackage ./keet {};
  custom_keet = pkgs.callPackage ./custom_keet {};
}
