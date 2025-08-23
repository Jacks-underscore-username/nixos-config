# inspo: https://discourse.nixos.org/t/fix-collision-with-multiple-jdks/10812/5
{pkgs, ...}: let
  jdks = with pkgs; [
    # jdk
    # jdk17
    # jdk11
    jetbrains.jdk-no-jcef
    jetbrains.jdk-no-jcef-17
    zulu8
  ];
in {
  programs.java = {
    enable = true;
    # This determines JAVA_HOME
    package = builtins.elemAt jdks 0;
  };

  home.sessionPath = ["$HOME/.jdks"];
  home.file = with pkgs;
    builtins.listToAttrs (builtins.map (jdk: {
        name = ".jdks/${jdk.version}";
        value = {source = jdk;};
      })
      jdks);
}
