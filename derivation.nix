{ pkgs ? import <nixpkgs> {}, stdenv, ... }: stdenv.mkDerivation {
  pname = "tux";
  version = "0.1.0";

  src = ./.;

  buildInputs = with pkgs; [
    poetry
    python313
    git
  ];

  buildPhase = ''
poetry env use 3.13.2
poetry install
  '';
  installPhase = ''
  '';
}