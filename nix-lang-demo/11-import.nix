# nix-env -iA nixpkgs.jq # 为了更好的展示结果，使用 jq 进行结果格式化展示。
# nix-instantiate --eval nix-lang-demo/11-import.nix --strict --json | jq
let
  import_file = import ./01-hello.nix;
  import_dir = import ./demopath;
in
{
  demo_01_import_file = import_file;
  demo_02_import_dir = import_dir;
}
