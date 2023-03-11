# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/03-func-data-type.nix --strict --json | jq
let
  addOne = x: x+1;
  add = x: y: x + y;
  addTwo = add 2;
  addAttrs = {x, y}: x + y;
  addAttrsYDefault2 = {x, y?2}: x + y;
  addAttrsAtAndRemaining = attrs@{x, y, ...}: x + attrs.y + attrs.z;
in {
  demo_01_add_one_2 = addOne 2;
  demo_02_add_1_2 = add 1 2;
  demo_03_add_two_1 = addTwo 1;
  demo_04_add_attrs_x1_y2 = addAttrs { x = 1; y = 2; };
  demo_05_add_attrs_y_default2_x1 = addAttrsYDefault2 { x = 1; };
  demo_06_add_attrs_at_and_remaining_x_1_y_1_z_1_q_3 = addAttrsAtAndRemaining { x = 1; y = 1; z = 1; q = 3; };
}
