{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {
  pname = "hyperssh";
  version = "5.0.4";

  src = fetchFromGitHub {
    owner = "holepunchto";
    repo = "hyperssh";
    tag = "v${finalAttrs.version}";
    hash = "sha256-R3D/MNYXLmgw4WbbYDLJpy8WnaseMqjzLOHqXu9458A=";
  };

  npmDepsHash = "";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = ["--ignore-scripts"];

  NODE_OPTIONS = "--openssl-legacy-provider";

  meta = {
    description = "SSH and SSHFS over the Hyperswarm DHT!";
    homepage = "https://github.com/holepunchto/hyperssh";
    license = lib.licenses.mit;
    maintainers = [];
  };
})
