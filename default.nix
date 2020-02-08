{ pkgs ? import <nixpkgs> {} }:
{
    uniutils = pkgs.callPackage ./pkgs/uniutils { };
    moar = pkgs.callPackage ./pkgs/moar { };
}
