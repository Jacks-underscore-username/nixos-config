# default.nix
let
  pkgs = import <nixpkgs> {};
in {
  balatro-mobile-maker = pkgs.callPackage ./balatro-mobile-maker.nix {};
}
