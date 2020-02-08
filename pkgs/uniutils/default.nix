# this expression builds uniutils with the latest Unicode data, that is, whatever pkgs.unicode-character-database is at
{ stdenv, fetchurl, unicode-character-database }:
let
versionSuffix = unicode-character-database.version;
in
stdenv.mkDerivation rec {
  pname = "uniutils";
  version = "2.27-" + versionSuffix; 
  src = fetchurl {
    # url = "http://billposer.org/Software/Downloads/uniutils-2.27.tar.gz"; # dead link as of April 2020
    url = "http://deb.debian.org/debian/pool/main/u/uniutils/uniutils_2.27.orig.tar.gz"; # same sha256 as upstream 
    sha256 = "15hmlsfwicdsqniqap0gz7dbv7a7bl9pkxhh0pkalrrsb8hsjqn6";
  };

  preConfigure = ''
    awk -f genunames.awk < ${unicode-character-database}/share/unicode/UnicodeData.txt  > unames.c ;
  '';

  meta = {
    description = "utilities for inspecting unicode text";
    homepage = "http://billposer.org/Software/uniutils.html"; # dead link as of April 2020
    license = stdenv.lib.licenses.gpl3;
  };
}
