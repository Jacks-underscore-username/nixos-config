# inspo: https://discourse.nixos.org/t/fix-collision-with-multiple-jdks/10812/5
{pkgs, ...}: {
  programs.java = {
    enable = true;
    # This determines JAVA_HOME - set to Java 21 at the moment as that is what modern Minecraft uses
    package = pkgs.jdk;
  };

  home.sessionPath = ["$HOME/.jdks"];
  home.file = with pkgs;
    builtins.listToAttrs (builtins.map (jdk: {
        name = ".jdks/${jdk.version}";
        value = {source = jdk;};
      })
      [
        jdk
        jdk17
        jdk11
        # pkgs.jetbrains.jdk
        # pkgs.jetbrains.jdk-no-jcef-17
      ]);
}
