# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/09-operators.nix --strict --json | jq
let
  attrs1 = {
    x = 1;
  };
  list1 = [1 2];
  list2 = [3 4];
in
{
  demo_01_attrs1_has_x = attrs1 ? x;
  demo_02_attrs1_has_y = attrs1 ? y;
  demo_03_attrs1_has_a_dot_b = attrs1 ? a.b;

  demo_04_list1_concat_list2 = list1 ++ list2;

  demo_05_str1_concat_str2 = "abc" + "123";
  # demo_06_path1_concat_path2 = demopath/a + demopath/b; # 严格模式将报错，因为返回的路径不存在。
  demo_07_path1_concat_str2 = "demopath/a" + demopath/b; 
  # demo_08_str1_concat_path2 = demopath/a + "demopath/b"; # 严格模式将报错，因为返回的路径不存在。

  demo_08_attrs = attrs1;
  demo_09_attrs1_merge_attrs2 = attrs1 // {y = 2;};

  demo_10_implication = false -> true;
}
