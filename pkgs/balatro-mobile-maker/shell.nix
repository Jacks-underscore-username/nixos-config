# shell.nix
let
  pkgs = import <nixpkgs> {};
  balatro-mobile-maker = pkgs.callPackage ./balatro-mobile-maker.nix {};
in
  pkgs.mkShell {
    packages = [
      balatro-mobile-maker
    ];
  }
