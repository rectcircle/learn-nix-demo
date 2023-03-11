# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/02-primitives-data-type.nix --strict --json | jq
let
  a = "1";
in {
  demo_01_str_double_quotes = "foo bar \r \t \n \\ \${";
  demo_02_str_with_string_interpolation = "a: ${a}";
  demo_03_str_two_single_quotes = ''
    line1
    line2
    \r \n \t \
    ''\r ''\t ''\n ''' ''${
    a: ${a}
    '';

  demo_04_str_url = https://rectcircle.cn;
  demo_05_num_int = 1;
  demo_06_num_float = 1.1;
  demo_07_num_e = .27e13;

  demo_08_path_abs_path = /bin/sh;
  demo_09_path_rel_path1 = ./demopath/a;
  demo_10_path_rel_path2 = demopath/a;
  demo_11_path_home_path = ~/.bashrc;

  demo_12_bool_true = true;
  demo_13_bool_false = false;

  demo_14_null = null;
}
