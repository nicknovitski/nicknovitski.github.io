{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  bundle = bundlerEnv {
    name = "github-pages";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in

stdenv.mkDerivation {
  name = "nicknovitski.com";
  src = ./.;
  buildInputs = [bundle];
  installPhase = ''
    mkdir -p $out
    cp -r $src/_site/* $out
  '';
}
