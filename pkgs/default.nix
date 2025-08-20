# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs:
with pkgs; {
  keet = callPackage ./keet {};
  jetbrainsJdks = import ./jetbrainsJdks {pkgs = pkgs;};
}
