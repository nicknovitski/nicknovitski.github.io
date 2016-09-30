{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  pkg = callPackage ./default.nix { };
in

stdenv.lib.overrideDerivation pkg (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [
    bundix
  ];
})
