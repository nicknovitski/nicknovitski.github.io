{ pkgs ? import <nixpkgs> {}, env ? "production" }:

with pkgs;

let
  bundle = bundlerEnv rec {
    name = "github-pages-${version}";
    version = (import ./gemset.nix).github-pages.version;
    ruby = ruby_2_3;
    gemdir = ./.;
  };
  self = stdenv.mkDerivation {
  name = "nicknovitski.com";
  src = ./.;
  buildInputs = [ bundle ];
  doCheck = true;
  SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  JEKYLL_ENV = env;
  LC_ALL = "en_US.UTF-8";
  installPhase = ''
    mkdir -p $out
    cp --recursive --target-directory $out ./_site/*
  '';
  passthru.update = writeScript "update-dependencies" ''
    pushd ${self.src}
    ${pkgs.bundler}/bin/bundle lock --update
    ${pkgs.bundix}/bin/bundix
    ${pkgs.nodePackages.node2nix}/bin/node2nix --composition /dev/null
    popd
  '';
};
in self
