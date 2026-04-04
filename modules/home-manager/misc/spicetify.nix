{
  pkgs,
  home,
  inputs,
  ...
}:
with inputs.spicetify-nix.legacyPackages.${pkgs.system}; {
  programs.spicetify = {
    enable = true;
    alwaysEnableDevTools = true;
    enabledExtensions = with extensions; [
      adblockify
      hidePodcasts
      shuffle
      betterGenres
      skipOrPlayLikedSongs
    ];
    theme = themes.starryNight;
    colorScheme = "Forest";
  };
}
