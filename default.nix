# nix-env -qaP my-nix-package-demo -f ./
# nix-env -iA my-nix-package-demo_0_0_1 -f ./
# nix-env -e my-nix-package-demo-0.0.1 ; nix-collect-garbage -d  # 彻底卸载。

{ pkgs ? import <nixpkgs> { } }:
{
  my-nix-package-demo_0_0_1 = import ./nix-lang-demo/12-derivation.nix { inherit pkgs; };
}