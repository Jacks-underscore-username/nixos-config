{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Jacks-underscore-username";
    userEmail = "jacksunderscoreusername@gmail.com";
    extraConfig = {
      push = {autoSetupRemote = true;};
    };
  };
}
