{ pkgs ? import <nixpkgs> {}, ...}:

pkgs.mkShell {
  packages = with pkgs; [
    python313
    poetry
    git
  ];

  shellHook = ''
    # enters the user's preferred shell
    $(grep $USER /etc/passwd | sed 's|.*:||g' | tr -d '\n')

    # exits after child shell exits
    exit
  '';
}