{ pkgs ? import <nixpkgs> {}, ... }: let
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

  poetryCore = let
    pname = "poetry-core";
    version = "2.1.2";
  in  buildPython {
      inherit pname version;
      src = builtins.fetchTarball {
        url = "https://files.pythonhosted.org/packages/84/2a/572c141e2a15b933b4a49eb888b0ae7335604f57c0f91a7298ae56d2df7c/poetry_core-2.1.2.tar.gz";
        sha256 = "1i58hpls09xdfz5z80jg20x1mfqjrx4fcq4rn1g6pkr0mvch6k6k";
      };
      format = "pyproject";
    };
in pkgs.python313Packages.buildPythonApplication {
    pname = "tux";
    version = "0.1.0";
    src = ./.;

    propagatedBuildInputs = with pkgs.python313Packages; [
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

    buildInputs =
      with pkgs.python313Packages; [
        poetryCore
        packaging
      ];

    format = "pyproject";
  }