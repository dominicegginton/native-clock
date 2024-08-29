{ pkgs, lib }:

pkgs.rustPlatform.buildRustPackage {
  pname = "native-clock";
  version = "0.0.1";
  src = lib.sources.cleanSource ./.;
  cargoSha256 = "sha256-uRb1VunzWK9xePTlMRLhJxeNQQJrkF2urNWeHPfSPok=";
  nativeBuildInputs = with pkgs; [
    cargo
    rustc
    pkg-config
    openssl
    sass
    glib
    cairo
    pango
    atk
    gdk-pixbuf
    libsoup
    gtk4
    webkitgtk
    librsvg
    patchelf
  ];

  configPhase = ''
    export CARGO_INSTALL_ROOT="${toString ./.}/.cargo";
  '';
}
