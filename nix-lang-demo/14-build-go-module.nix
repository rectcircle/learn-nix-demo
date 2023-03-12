# https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/go/module.nix
{ pkgs ? import <nixpkgs> { } }:
pkgs.buildGoModule {
  pname = "my-nix-package-demo-by-build-go-module";
  version = "0.0.1";
  src = fetchGit {
    name = "learn-nix-demo-source";
    url = "https://github.com/rectcircle/learn-nix-demo.git";
    rev = "7f4952a6ecf7dcd90c8bb0c8d14795ae1add5326";
    ref = "master";
    shallow = true;
  };

  vendorHash = null;  # 自动生成。

  modRoot = "./nix-package-demo";
  CGO_ENABLED = false;
  postInstall = ''
    mv $out/bin/nix-package-demo $out/bin/$pname
  '';
}
