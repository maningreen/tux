{ pkgs ? import <nixpkgs> {}, ... }: pkgs.python3Packages.buildPythonApplication {
  pname = "tux";
  version = "0.1.0";
  src = ./.;

  propagatedBuildInputs = let
    reactionmenu = pkgs.python3Packages.buildPythonApplication rec {
      pname = "reactionmenu";
      version = "3.1.7";
      src = pkgs.fetchPypi {
        inherit pname version;
        hash = "sha256-ENo8GWbeK2Jk/N9yU3NIkjxeFRUBZEN1wl9DC/2HBGM=";
      };
      propagatedBuildInputs = [ pkgs.python3Packages.discordpy ];
    };
  in with pkgs.python3Packages; [
    prisma
    loguru
    discordpy
    githubkit
    httpx
    python-dotenv
    sentry-sdk
    reactionmenu
    pillow
    requests
  ];

  buildInputs = with pkgs.python3Packages; [
    poetry-core
  ];

  format = "pyproject";
}