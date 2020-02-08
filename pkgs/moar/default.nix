{ buildGoPackage, fetchFromGitHub, highlight }:
buildGoPackage rec {
  pname = "moar-pager"; # not to be confused with moarvm 
  version = "0.9.22";
  src = fetchFromGitHub {
    owner = "walles";
    repo = "moar";
    rev = version;
    sha256 = "14bad0irqbrqv0rjqmkgq9wq9pxnijh5bjahhcyjyildivlssvsn";
  };
  goDeps = ./deps.nix;
  goPackagePath = "github.com/walles/moar";
  buildFlags = [ ''-ldflags="-Xmain.versionString=${version}"'' ]; # TODO: This actually does nothing

  meta = {
    description = "a terminal pager";
    homepage = "https://github.com/walles/moar";
    license = "BSD-2-Clause-FreeBSD";
  };
}