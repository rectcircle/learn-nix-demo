{pkgs ? import <nixpkgs> { } }:
let
  stdenv = pkgs.stdenv;
in 
stdenv.mkDerivation {
  pname = "my-nix-package-demo-build-by-my-mk-derivation";
  version = "0.0.1";
  src = fetchGit {
    name = "learn-nix-demo-source";
    url = "https://github.com/rectcircle/learn-nix-demo.git";
    rev = "7f4952a6ecf7dcd90c8bb0c8d14795ae1add5326";
    ref = "master";
    shallow = true;
  };
  nativeBuildInputs = [ pkgs.go_1_19 pkgs.git ];
  buildPhase = ''
    cd nix-package-demo && CGO_ENABLED=0 go build -o $pname ./
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp $pname $out/bin
  '';
}
