{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      stdenv = pkgs.stdenv;
      lib = stdenv.lib;
      rustPlatform = pkgs.rustPlatform;
    in rec {
      defaultPackage = rustPlatform.buildRustPackage rec {
        pname = "native-clock";
        version = "0.0.1";
        src = ./.;
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
          gtk3
          webkitgtk
          librsvg
          patchelf
        ];
        cargoSha256 = "sha256-uRb1VunzWK9xePTlMRLhJxeNQQJrkF2urNWeHPfSPok=";
      };

      devShell = pkgs.mkShell {
        CARGO_INSTALL_ROOT = "${toString ./.}/.cargo";
        buildInputs = with pkgs; [
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
          gtk3
          webkitgtk
          librsvg
          patchelf
        ];
      };
    });
}
