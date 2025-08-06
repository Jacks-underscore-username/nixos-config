{
  lib,
  fetchFromGitHub,
  buildDotnetModule,
  dotnetCorePackages,
}:
buildDotnetModule {
  pname = "balatro-mobile-maker";
  version = "0.8.3";

  src = fetchFromGitHub {
    owner = "blake502";
    repo = "balatro-mobile-maker";
    rev = "9fd41b536841d19a82fa834d563c12118d685106";
    hash = "sha256-Ccai8Dcbv9TOrTMoEJj26oeWX0cWhwyOb3xmJgl5xHg=";
  };

  projectFile = "balatro-mobile-maker/balatro-mobile-maker.csproj";
  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;
  nugetDeps = ./deps.nix;

  meta = with lib; {
    homepage = "https://github.com/blake502/balatro-mobile-maker";
    description = "Create a mobile Balatro app from your Steam version of Balatro";
    license = licenses.mit;
  };
}
