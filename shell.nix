{ pkgs, mkShell }:

mkShell {
  CARGO_INSTALL_ROOT = "${toString ./.}/.cargo";
  inputsFrom = [ pkgs.native-clock ];
}
