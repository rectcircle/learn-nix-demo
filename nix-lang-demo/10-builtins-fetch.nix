# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/10-builtins-fetch.nix --strict --json | jq
let
  fetchurl = builtins.fetchurl;
  fetchGit = builtins.fetchGit;
  fetchTarball = builtins.fetchTarball;
in
{
  demo_01_fetchurl = fetchurl {
    url = "http://ftp.nluug.nl/pub/gnu/hello/hello-2.1.1.tar.gz";
    sha256 = "1md7jsfd8pa45z73bz1kszpp01yw6x5ljkjk2hx7wl800any6465";
  };
  demo_02_fetchGit = fetchGit {
    name = "learn-nix-demo-source";
    url = "https://github.com/rectcircle/learn-nix-demo.git";
    rev = "7f4952a6ecf7dcd90c8bb0c8d14795ae1add5326";
    ref = "master";
    shallow = true;
  };
  demo_03_fetchTarball = fetchTarball {
    url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/releases/nixpkgs-unstable%40nixpkgs-23.05pre462063.2ce9b9842b5/nixexprs.tar.xz";
  };
}
