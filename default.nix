# nix-env -qaP -f ./
# nix-env -iA my-nix-package-demo_0_0_1 -f ./
# nix-env -e my-nix-package-demo-0.0.1 ; nix-collect-garbage -d  # 彻底卸载。
# nix-env -iA my-nix-package-demo-build-by-my-mk-derivation_0_0_1 -f ./
# nix-env -e my-nix-package-demo-build-by-my-mk-derivation-0.0.1 ; nix-collect-garbage -d  # 彻底卸载。
# nix-env -iA my-nix-package-demo-by-build-go-module_0_0_1 -f ./
# nix-env -e my-nix-package-demo-by-build-go-module-0.0.1 ; nix-collect-garbage -d  # 彻底卸载。

{ pkgs ? import <nixpkgs> { } }:
{
  my-nix-package-demo_0_0_1 = import ./nix-lang-demo/12-derivation.nix { inherit pkgs; };
  my-nix-package-demo-build-by-my-mk-derivation_0_0_1 = import ./nix-lang-demo/13-mkderivation.nix { inherit pkgs; };
  my-nix-package-demo-by-build-go-module_0_0_1 = import ./nix-lang-demo/14-build-go-module.nix { inherit pkgs; };
}