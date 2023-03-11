# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/07-flow-control.nix --strict --json | jq
let
  x = 1;
  l = [1 2 3 4 5 6];
  filter = builtins.filter;
  map = builtins.map;
in {
  demo_01_x_great_than_0 = if x > 0 then "x > 0" else "x <= 0";
  demo_02_l_filter_map = map (e: e * 2) (filter (e: e<=3) l);
}
