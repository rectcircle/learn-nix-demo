# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/04-list-data-type.nix --strict --json | jq
let
  addAttrs = { x, y }: x + y;
  demo_01_list_1 = [ 123 demopath/a "abc" (addAttrs { x = 1; y = 2; }) ];
  demo_01_list_2 = [ 123 demopath/a "abc" addAttrs { x = 1; y = 2; } ];
in
{
  demo_01_list_1 = demo_01_list_1;
  demo_01_list_2_len = builtins.length demo_01_list_2;
}
