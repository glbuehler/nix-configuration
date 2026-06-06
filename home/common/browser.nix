{ pkgs, ... }:
{

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { # markdown viewer
        id = "ckkdlimhmcjmikdlpkmbgfkaikojcbjk";
      }
      { # dark reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      }
    ];
  };

}
