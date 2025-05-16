{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [python314 pico-sdk openocd cmake ninja libusb1];
  buildInputs = with pkgs; [libusb1]; # Try libusb1
}
