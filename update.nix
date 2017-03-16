{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  default = import ./default.nix { inherit pkgs; };
  shellOnlyPackage = name: shellHook:
    pkgs.stdenv.mkDerivation {
      inherit name shellHook;
      buildCommand = ''
        echo "+-----------------------------------------------------+"
        echo "| Not possible to build package using \`nix-build\`. \|"
        echo "|         Please run \`nix-shell\` instead.          \|"
        echo "+-----------------------------------------------------+"
        exit 1
      '';
    };
in
shellOnlyPackage "update" ''
  export HOME=$PWD
  echo "Updating packages ..."
  ${default.update}
  echo "Packages updated!"
  exit
  ''
