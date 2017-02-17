{ pkgs ? import <nixpkgs> {}, env ? "development" }:

with pkgs;

let
  pkg = callPackage ./. { inherit env; };
  nodeEnv = import ./node-env.nix {
    inherit (pkgs) stdenv python nodejs utillinux runCommand writeTextFile;
  };
  npkgs = import ./node-packages.nix {
    inherit (pkgs) fetchurl fetchgit;
    inherit nodeEnv;
  };
in

stdenv.lib.overrideDerivation pkg (oldAttrs: {
  buildInputs = oldAttrs.buildInputs ++ [
    npkgs.write-good
  ];
  shellHook = "alias s='jekyll serve -H 0.0.0.0'";
})
