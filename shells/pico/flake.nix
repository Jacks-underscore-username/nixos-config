{
  description = "Development environment for a Pico project";

  inputs = {
    # Input for the stable channel (optional, but good practice)
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11"; # Replace with your preferred stable channel
    # Input for the unstable channel
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs-stable,
    nixpkgs-unstable,
    ...
  }: let
    # Define the system architecture
    system = "x86_64-linux";

    # Get the package sets for the stable and unstable channels
    pkgs_stable = nixpkgs-stable.legacyPackages.${system};
    pkgs_unstable = nixpkgs-unstable.legacyPackages.${system};

    # Configure the unstable channel to allow unfree packages if needed
    pkgs_stable_configured = import nixpkgs-stable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    pkgs_unstable_configured = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    # Define the dependencies, primarily from the unstable channel
    deps = with pkgs_unstable_configured; [
      python314
      pico-sdk
      openocd
      cmake
      ninja
      gdb
      libftdi1
      pkgs_stable_configured.vscode
      pkgs_stable_configured.git
    ];

    # Define the library paths
    libusbLibPath = "${pkgs_unstable_configured.libusb1}/lib";
    picoSdkPath = "${pkgs_unstable_configured.pico-sdk}/lib/pico-sdk";
  in {
    # Define the default development shell
    devShells.${system}.default = pkgs_stable.mkShell {
      # Use pkgs_stable for mkShell itself
      nativeBuildInputs = deps;
      buildInputs = deps;

      shellHook = ''
        export LD_LIBRARY_PATH="${libusbLibPath}:$LD_LIBRARY_PATH"
        export PICO_SDK_PATH="${picoSdkPath}$PICO_SDK_PATH"

        echo "Entering development shell for Pico project."
        echo "Using packages from the unstable channel."
      '';
    };
  };
}
