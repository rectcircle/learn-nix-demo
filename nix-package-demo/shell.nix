# { pkgs ? import <nixpkgs> { } }:
let 
  pkgs = import ( builtins.fetchTarball { 
    url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/releases/nixpkgs-unstable%40nixpkgs-23.05pre460011.f5ffd578778/nixexprs.tar.xz"; 
  }) {};
in
pkgs.mkShell {
  buildInputs =
    [
      pkgs.curl
      pkgs.jq
      pkgs.go
      pkgs.which
    ];
  shellHook = ''
    export TEST_ENV_VAR=ABC
  '';
}
