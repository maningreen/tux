{ pkgs ? import <nixpkgs> {}, ... }: pkgs.python313Packages.buildPythonApplication {
  pname = "tux";
  version = "0.1.0";
  src = ./.;

  propagatedBuildInputs = let
    buildPython = pkgs.python313Packages.buildPythonApplication;

    reactionmenu = let
      pname = "reactionmenu";
      version = "3.1.7";
    in pkgs.python3Packages.buildPythonApplication {
        inherit pname version;
        src = pkgs.fetchPypi {
          inherit pname version;
          hash = "sha256-ENo8GWbeK2Jk/N9yU3NIkjxeFRUBZEN1wl9DC/2HBGM=";
        };
        propagatedBuildInputs = [ pkgs.python3Packages.discordpy ];
      };

    jishaku = let
      pname = "jishaku";
      version = "2.6.0";
    in buildPython {
        inherit pname version;
        src = pkgs.fetchPypi {
          inherit pname version;
          hash = "sha256-ubTQU7jL22qP16jVSdCSjC5SlARMuxRcuybfNvl84ok=";
        };
      };

    asynctempfile = let
      pname = "asynctempfile";
      version = "0.5.0";
    in buildPython {
        inherit pname version;
        src = pkgs.fetchPypi {
          inherit pname version;
          hash = "sha256-SmR8dHNX6IJzl7qtvf6H8wldMJI/p4nnlxEesCFgiEo=";
        };
      };

    audioop-lts = buildPython {
      pname = "audioop-lts";
      version = "0.2.1";
      src = pkgs.fetchFromGitHub {
        owner = "AbstractUmbra";
        repo = "audioop";
        tag = "0.2.1";
        hash = "sha256-tx5/dcyEfHlYRohfYW/t0UkLiZ9LJHmI8g3sC3+DGAE=";
      };
      buildInputs = with pkgs.python313Packages; [
        setuptools
      ];
    };
  in with pkgs.python313Packages; [
      aiocache
      prisma
      loguru
      discordpy
      githubkit
      httpx
      python-dotenv
      sentry-sdk_2
      reactionmenu
      pillow
      requests
      aioconsole
      aiofiles
      cairosvg
      colorama
      dateparser
      jishaku
      psutil
      pytz
      pyyaml
      rich
      rsa
      asynctempfile
      audioop-lts
    ];

  nativeBuildInputs = with pkgs.python313Packages; [
    poetry-core
    packaging
  ];

  format = "pyproject";
}