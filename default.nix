{ pkgs ? import <nixpkgs> {} }:
{
    uniutils = pkgs.callPackage ./pkgs/uniutils { };
    moar = pkgs.callPackage ./pkgs/moar { };
    slit = pkgs.callPackage ./pkgs/slit { };
    faq = pkgs.callPackage ./pkgs/faq { };
    git-archive-all = pkgs.callPackage ./pkgs/git-archive-all { };
    cubeglobe-bot = pkgs.callPackage ./pkgs/cubeglobe-bot { };
    rdrview = pkgs.callPackage ./pkgs/rdrview { };
}
