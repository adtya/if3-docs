{ stdenvNoCC, mdbook }:

stdenvNoCC.mkDerivation {
  pname = "if3";
  version = "2023-11-05";
  src = ./.;
  buildInputs = [ mdbook ];
  buildPhase = ''
    mdbook build
  '';
  installPhase = ''
    mkdir -p $out/share
    cp -r book $out/share/web
  '';
}
