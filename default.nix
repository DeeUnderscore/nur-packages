{ pkgs ? import <nixpkgs> {} }:
{
    uniutils = pkgs.callPackage ./pkgs/uniutils { };
    moar = pkgs.callPackage ./pkgs/moar { };
    slit = pkgs.callPackage ./pkgs/slit { };
    faq = pkgs.callPackage ./pkgs/faq { };
}
