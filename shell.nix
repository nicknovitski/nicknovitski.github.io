{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  pkg = callPackage ./. { };
in

stdenv.lib.overrideDerivation pkg (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [
    bundix
  ];
})
