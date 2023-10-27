{
  stdenvNoCC,
  mdbook,
}:
stdenvNoCC.mkDerivation {
  pname = "if3";
  version = "latest";
  src = ./.;
  buildInputs = [mdbook];
  buildPhase = ''
    mdbook build
  '';
  installPhase = ''
    mkdir -p $out/share
    cp -r book $out/share/web
  '';
}
