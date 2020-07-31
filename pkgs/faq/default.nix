{ stdenv, fetchFromGitHub, buildGoPackage, jq }:
buildGoPackage rec {
  pname = "faq";
  version = "0.0.6";

  src = fetchFromGitHub {
    owner = "jzelinskie";
    repo = "faq";
    rev = version;
    sha256 = "0qrkmx7l008ya116v4d43x37psgkkvl53azyzj7hcg0g3qyz9ps4";
  };
  goDeps = ./deps.nix;
  goPackagePath = "github.com/jzelinskie/faq";
  buildInputs = [ jq ] ++ jq.buildInputs ; # need jq buildable at build faq time

  meta = {
    description = "format-agnostic jq";
    homepage = "https://github.com/jzelinskie/faq";
    license = stdenv.lib.licenses.asl20;
  };
}
