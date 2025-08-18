{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {
  pname = "hyperssh";
  version = "4.7.0";

  src = fetchFromGitHub {
    owner = "jesec";
    repo = "hyperssh";
    tag = "v${finalAttrs.version}";
    hash = "sha256-BR+ZGkBBfd0dSQqAvujsbgsEPFYw/ThrylxUbOksYxM=";
  };

  npmDepsHash = "sha256-tuEfyePwlOy2/mOPdXbqJskO6IowvAP4DWg8xSZwbJw=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = ["--ignore-scripts"];

  NODE_OPTIONS = "--openssl-legacy-provider";

  meta = {
    description = "Modern web UI for various torrent clients with a Node.js backend and React frontend";
    homepage = "https://github.com/holepunchto/hyperssh";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [winter];
  };
})
