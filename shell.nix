{ pkgs ? import <nixpkgs> {}, env ? "development" }:

with pkgs;

let
  pkg = callPackage ./. { };
in

stdenv.lib.overrideDerivation pkg (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [
    bundix
  ];
  JEKYLL_ENV = env;
})
