{pkgs, ...}: let
  ver = {
    version,
    build,
    tag,
    hash,
    sourceEpoc,
  } @ javaConfig:
    pkgs.callPackage ./generic.nix {inherit javaConfig;};
in {
  "21.0.6" = ver {
    version = "21.0.6";
    build = "895.109";
    tag = "jbr-21.0.6+7";
    hash = "sha256-Neh0PGer4JnNaForBKRlGPLft5cae5GktreyPRNjFCk=";
    sourceEpoc = 1726275531;
  };
}
