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
  doCheck = true;
  JEKYLL_ENV = env;
  LC_ALL = "en_US.UTF-8";
  installPhase = ''
    mkdir -p $out
    cp -r $src/_site/* $out
  '';
}
