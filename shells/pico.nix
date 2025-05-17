{
  # Import the stable channel
  pkgs ? import <nixpkgs> {},
  # Import the unstable channel
  pkgs_unstable ? import <nixpkgs> {config = {allowUnfree = true;};}, # Allow unfree if needed for unstable
}: let
  libusbLibPath = "${pkgs_unstable.libusb1}/lib";
  picoSdkPath = "${pkgs_unstable.pico-sdk}/lib/pico-sdk";
  deps = with pkgs_unstable.buildPackages; [python314 pico-sdk openocd cmake ninja gdb libftdi1 vscode git];
in
  pkgs.mkShell {
    nativeBuildInputs = deps;
    buildInputs = deps;
    shellHook = ''
      export LD_LIBRARY_PATH="${libusbLibPath}:$LD_LIBRARY_PATH"
      export PICO_SDK_PATH="${picoSdkPath}$PICO_SDK_PATH"
    '';
  }
