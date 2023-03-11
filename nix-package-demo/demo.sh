#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash go_1_19 jq curl which
#! nix-shell -I nixpkgs=https://mirrors.tuna.tsinghua.edu.cn/nix-channels/releases/nixpkgs-unstable%40nixpkgs-23.05pre460011.f5ffd578778/nixexprs.tar.xz

echo $PATH
which go
which jq
which curl
