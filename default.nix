{ pkgs ? import <nixpkgs> {}, env ? "production" }:

with pkgs;

let
  bundle = bundlerEnv rec {
    name = "github-pages-${version}";
    version = (import ./gemset.nix).github-pages.version;
    ruby = ruby_2_3;
    gemdir = ./.;
  };
in

stdenv.mkDerivation {
  name = "nicknovitski.com";
  src = ./.;
  buildInputs = [ bundle ];
  doCheck = true;
  JEKYLL_ENV = env;
  LC_ALL = "en_US.UTF-8";
  installPhase = ''
    mkdir -p $out
    cp -r $src/_site/* $out
  '';
}
