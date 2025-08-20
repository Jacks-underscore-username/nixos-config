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
    })
  # (ver
  #   {
  #     version = "17.0.12";
  #     build = "1207.37";
  #     tag = "jdk-18+0";
  #     hash = "sha256-L+PGirdcuZYWzl1ryvNdXVY2NRCw9cKj6McW13r/sAw=";
  #     sourceEpoc = 1727269058;
  #   })
]
