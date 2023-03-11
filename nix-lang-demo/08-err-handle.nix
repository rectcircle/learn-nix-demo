# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/08-err-handle.nix --strict --json | jq
let
  divide = a: b: assert b !=0 ; a / b;
  throw_err = msg: builtins.throw msg;
  abort_err = msg: builtins.abort msg;
in {
  demo_01_4_div_2 = divide 4 2;
  demo_02_try_4_div_0 = builtins.tryEval (divide 4 0);
  demo_03_try_4_div_2 = builtins.tryEval (divide 4 2);
  demo_04_try_throw_err = builtins.tryEval (throw_err "err");
  # demo_05_try_abort_err = builtins.tryEval (abort_err "err"); # abort 无法捕捉
  # demo_06_try_builtins_4_div_0 = builtins.tryEval (4 / 0); # 除 0 无法捕捉
}
