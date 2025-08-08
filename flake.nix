{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix/24.11";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # systems = [
    # "aarch64-linux"
    # "i686-linux"
    # "x86_64-linux"
    # "aarch64-darwin"
    # "x86_64-darwin"
    # ];
    # forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          inputs.disko.nixosModules.default

          ./nixos/configuration.nix

          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
        ];
      };
    };
  };
}
