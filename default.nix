{ pkgs ? import <nixpkgs> {} }:
rec {
    cubeglobe-bot = pkgs.callPackage ./pkgs/cubeglobe-bot { };
    faq = pkgs.callPackage ./pkgs/faq { };
    git-archive-all = pkgs.callPackage ./pkgs/git-archive-all { };
    moar = pkgs.callPackage ./pkgs/moar { };
    rdrview = pkgs.callPackage ./pkgs/rdrview { };
    slit = pkgs.callPackage ./pkgs/slit { };
    uniutils = pkgs.callPackage ./pkgs/uniutils { };
    libuiohook = pkgs.callPackage ./pkgs/libuiohook { };
    obs-input-overlay = pkgs.callPackage ./pkgs/obs-input-overlay { inherit libuiohook; };
}
