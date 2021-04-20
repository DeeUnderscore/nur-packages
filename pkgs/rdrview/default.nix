{ stdenv
, lib
, fetchFromGitHub
, libxml2
, libseccomp
, curl
}:
stdenv.mkDerivation {
  pname = "rdrview";
  version = "unstable-2020-10-20";

  src = fetchFromGitHub {
    owner = "eafer";
    repo = "rdrview";
    rev = "00207dc516b035ae7760d005bd559077cc18e0b2";
    sha256 = "0nkcsyl923zzrby8rdgsh97nzp7kg70j063frxh6bh3ikjd5sjgq";
  };

  buildInputs = [ libxml2 libseccomp curl ];
  installPhase = ''
    make install BINDIR="$out/bin" MANDIR="$out/share/man/man1"
  '';

  meta = {
    description = "Firefox Reader View as a Linux command line tool ";
    homepage = "https://github.com/eafer/rdrview";
    license = lib.licenses.asl20;
  };
}
