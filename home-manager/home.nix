{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../modules/home-manager/default.nix
    inputs.spicetify-nix.homeManagerModules.default
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.unstable-small-packages
    ];
    config.allowUnfree = true;
  };

  home = {
    username = "jackc";
    homeDirectory = "/home/jackc";
  };

  # Let home manager manage itself.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
