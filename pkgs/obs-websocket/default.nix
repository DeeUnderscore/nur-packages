{ mkDerivation
, lib
, fetchFromGitHub
, cmake
, obs-studio
, qtbase
} :

mkDerivation rec {
  name = "obs-websocket";
  version = "4.9.0";

  src = fetchFromGitHub {
    owner = "Palakis";
    repo = "obs-websocket";
    rev = version;
    sha256 = "1r47861ma1s3998clahbnbc216wcf706b1ps514k5p28h511l5w0";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ 
    obs-studio
    qtbase
  ];

  meta = {
    description = "Plugin for obs-studio providing a remote control API with websockets.";
    homepage = "https://github.com/Palakis/obs-websocket";
    license = lib.licenses.gpl2Plus;
    broken = lib.versionOlder lib.version "21.05pre";
  };

}