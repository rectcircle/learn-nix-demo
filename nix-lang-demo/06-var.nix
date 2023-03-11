# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/06-var.nix --strict --json | jq

let 
  a = 1;
  b = 2;
  attrs1 = {
    x = 3;
    y = 4;
  };
  attrs2 = {
    m = 5;
    n = 6;
  };
in with attrs2;
{
  inherit a b;
  inherit (attrs1) x y;
  m = m;
  inherit n;
}
