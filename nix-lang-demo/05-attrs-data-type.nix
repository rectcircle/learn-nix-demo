# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/05-attrs-data-type.nix --strict --json | jq
let
  bKey = "b";
  dKey = "d";
  demo_01_define = {
    a = 1;
    b = "b";
    "$!@#?" = 123;
    ${dKey} = 4;
    ${null} = true;
  };
  demo_02_access = {
    a = demo_01_define.a;
    b = demo_01_define.${bKey};
    c = demo_01_define.c or "c not exist";
    "$!@#?" = demo_01_define."$!@#?";
    d = demo_01_define.d;
  };

  callable_attr_define = { __functor = self: x: x + self.x; };
  demo_03_callable_attr_object = callable_attr_define // { x = 1; };

  demo_04_rec_attr1 = rec {
    y = 123;
    x = y;
  };
  y = 456;
  demo_05_rec_attr2 = rec {
    x = y;
    y = 123;
  };
in
{
  demo_01_define = demo_01_define;
  demo_02_access = demo_02_access;
  demo_03_call_attr = demo_03_callable_attr_object 2;
  demo_04_rec_attr1 = demo_04_rec_attr1;
  demo_05_rec_attr2 = demo_05_rec_attr2;
}
