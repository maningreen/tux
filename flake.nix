{
  # TODO: make an actually good desc lol
  description = "A flake for the development and installation of the All Thing's Linux discord server's bot tux";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    basePkgs = with pkgs; [
      poetry
      python313
    ];
    version = "0.1.0";
  in {
    devShells.${system}.default = pkgs.mkShell {

      packages = with pkgs; [
      ] ++ basePkgs;

      shellHook = ''
        echo "Have fun developing :) - green"
      '';

    };
    defaultPackage.${system} = pkgs.stdenv.mkDerivation {
      pname = "tux";
      version = version;

      src = ./.;

      buildInputs = with pkgs; [
      ] ++ basePkgs;

      buildPhase = ''
# manage poetry

poetry env use 3.13.2
poetry -v install
'';

      installPhase = ''
          # todo put something here :p
          echo "hi there"
          '';
    };
  };
}