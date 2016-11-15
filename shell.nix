{ pkgs ? import <nixpkgs> {}, env ? "development" }:

with pkgs;

let
  pkg = callPackage ./. { inherit env; };
in

stdenv.lib.overrideDerivation pkg (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [
    bundix
  ];
  shellHook = "alias s='jekyll serve -H 0.0.0.0'";
})
