{ pkgs ? import <nixpkgs> {}, env ? "production" }:

with pkgs;

let
  bundle = bundlerEnv {
    name = "github-pages";
    ruby = ruby_2_1;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in

stdenv.mkDerivation {
  name = "nicknovitski.com";
  src = ./.;
  buildInputs = [bundle];
  JEKYLL_ENV = env;
  installPhase = ''
    mkdir -p $out
    cp -r $src/_site/* $out
  '';
}
