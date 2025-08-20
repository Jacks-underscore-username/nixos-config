{pkgs, ...}: let
  ver = {
    version,
    build,
    # To get the new tag:
    # git clone https://github.com/jetbrains/jetbrainsruntime
    # cd jetbrainsruntime
    # git checkout jbr-release-${javaVersion}b${build}
    # git log --simplify-by-decoration --decorate=short --pretty=short | grep "jbr-" --color=never | cut -d "(" -f2 | cut -d ")" -f1 | awk '{print $2}' | sort -t "-" -k 2 -g | tail -n 1 | tr -d ","
    #   openjdkTag = "jbr-21.0.6+7";
    tag,
    hash,
    # run `git log -1 --pretty=%ct` in jdk repo for new value on update
    sourceEpoc,
    jdk,
    bootstrap-jdk,
  } @ javaConfig:
    pkgs.callPackage ./generic.nix {inherit javaConfig;};
in [
  (ver
    {
      version = "21.0.6";
      build = "895.109";
      tag = "jbr-21.0.6+7";
      hash = "sha256-Neh0PGer4JnNaForBKRlGPLft5cae5GktreyPRNjFCk=";
      sourceEpoc = 1726275531;
      jdk = pkgs.jdk;
      bootstrap-jdk = pkgs.jdk;
    })
  # (ver
  #   {
  #     version = "17.0.11";
  #     build = "1207.24";
  #     tag = "jbr-17.0.8+7";
  #     hash = "sha256-a7cJF2iCW/1GK0/GmVbaY5pYcn3YtZy5ngFkyAGRhu0=";
  #     sourceEpoc = 1715809405;
  #     jdk = pkgs.openjdk17;
  #     bootstrap-jdk = pkgs.openjdk17-bootstrap;
  #   })
]
