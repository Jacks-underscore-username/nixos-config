{pkgs ? import <nixpkgs> {}}: let
  # Find the libusb library path dynamically (more robust)
  libusbLibPath = "${pkgs.libusb1}/lib"; # Or ${pkgs.libusb1}/lib if you switched
in
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [python314 pico-sdk openocd cmake ninja gdb libftdi1];
    buildInputs = with pkgs; [libusb1];
    shellHook = ''
      export LD_LIBRARY_PATH="${libusbLibPath}:$LD_LIBRARY_PATH"
    '';
  }
