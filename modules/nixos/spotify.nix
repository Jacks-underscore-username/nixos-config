{...}: {
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "algorithmaiden@gmail.com";
        password = "TheAidenCode";
      };
    };
  };
  services.playerctld.enable = true;
}
