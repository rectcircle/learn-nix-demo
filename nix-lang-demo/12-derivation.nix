# drv_path=$(nix-instantiate nix-lang-demo/12-derivation.nix) && echo "drv_path: $drv_path" && echo "drv: $(nix --extra-experimental-features nix-command show-derivation $drv_path)" && nix-store -r $drv_path && nix-store --read-log $drv_path
# nix-env -e my-nix-package-demo-0.0.1 ; nix-collect-garbage -d  # 彻底卸载。

# 整体来开，该文件定义了一个函数，该函数，参数为 pkgs 默认会拿系统中的 nixpkgs，返回一个 derivation 的返回值。
{pkgs ? import <nixpkgs> { } }:
let
  derivation = builtins.derivation;
  # pkgs = import <nixpkgs> {};
  # 从 github 中获取示例项目的源码，会存储到 /nix/store 中的一个子目录中。source 的值是一个指向这个子目录的路径。
  source = fetchGit {
    name = "learn-nix-demo-source";
    url = "https://github.com/rectcircle/learn-nix-demo.git";
    rev = "7f4952a6ecf7dcd90c8bb0c8d14795ae1add5326";
    ref = "master";
    shallow = true;
  };
in 
derivation {
  # 由于 go 项目是跨平台的，所以，这里直接使用 builtins.currentSystem，表示支持任意平台。
  system = builtins.currentSystem;
  name = "my-nix-package-demo-0.0.1";
  # 会启动 nixpkgs 的 bash 来构建项目。
  builder = "${pkgs.bash}/bin/bash";
  # 额外的环境变量，会传递到 builder 进程。
  A = "1";
  # bash 命令的参数。即 bash -c 脚本 。
  args = [ "-c" 
  # 在这个脚本，观察下，nix 如何设置这个脚本的环境变量，以及文件系统，参见输出。
  ''
    set -e
    ${pkgs.coreutils}/bin/echo ">>> export -p" && export -p && echo

    echo ">>> export PATH=${pkgs.go_1_19}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin" && export PATH="${pkgs.go_1_19}/bin:${pkgs.bash}/bin:${pkgs.coreutils}/bin" && echo

    echo ">>> pwd" && pwd && echo
    echo ">>> id" && id && echo
    echo ">>> ls -al /" && ls -al / && echo
    echo ">>> ls -al /bin" && ls -al /bin && echo
    echo ">>> ls -al /build" && ls -al /build && echo
    echo ">>> ls -al /nix/store" && ls -al /nix/store && echo

    echo ">>> mkdir -p $out/bin" && mkdir -p $out/bin && echo
    echo ">>> cd ${source}/nix-package-demo && CGO_ENABLED=0 go build -o $out/bin/my-nix-package-demo ./" && cd ${source}/nix-package-demo && CGO_ENABLED=0 go build -o $out/bin/my-nix-package-demo ./ && echo

    echo ">>> ls -al $out/bin" && ls -al $out/bin && echo
  ''];
}
