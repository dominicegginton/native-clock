{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:

    with flake-utils.lib;

    eachSystem [ "x86_64-linux" ] (system:

      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [ (_: prev: { native-clock = prev.callPackage ./default.nix { }; }) ];
        };
      in

      {
        formatter = pkgs.nixpkgs-fmt;
        packages.default = pkgs.native-clock;
        devShells.default = pkgs.callPackage ./shell.nix { };
      });
}
