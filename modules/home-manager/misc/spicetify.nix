{
  pkgs,
  home,
  inputs,
  ...
}: let
in {
  programs.spicetify = {
    enable = true;
    # alwaysEnableDevTools = true;
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      # adblockify
      # hidePodcasts
      shuffle
      # betterGenres
      # skipOrPlayLikedSongs
    ];
    # theme = spicePkgs.themes.starryNight;
    # colorScheme = "Forest";
  };
}
