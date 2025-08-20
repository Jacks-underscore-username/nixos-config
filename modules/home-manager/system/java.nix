# inspo: https://discourse.nixos.org/t/fix-collision-with-multiple-jdks/10812/5
{pkgs, ...}: {
  programs.java = {
    enable = true;
    # This determines JAVA_HOME - set to Java 21 at the moment as that is what modern Minecraft uses
    package = builtins.elemAt pkgs.jetbrainsJdks 0;
  };

  home.sessionPath = ["$HOME/.jdks"];
  home.file = builtins.listToAttrs (builtins.map (jdk: {
      name = ".jdks/${jdk.version}";
      value = {source = jdk;};
    })
    pkgs.jetbrainsJdks);
}
