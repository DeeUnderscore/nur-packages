{ stdenv
, lib
, fetchFromGitHub
, cmake
, pkg-config
, xorg
, libxkbcommon } :
stdenv.mkDerivation { 
  pname = "libuiohook";
  version = "unstable-2021-01-07";
  src = fetchFromGitHub {
    owner = "kwhat";
    repo = "libuiohook";
    rev = "f4bb19be8aee7d7ee5ead89b5a89dbf440e2a71a";
    sha256 = "1lmgbvsmmpfi49556hpb3izak7mdfbkk4ngw523afp45by7n8x1a";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [ 
    xorg.libX11
    xorg.libXtst
    xorg.libXt
    xorg.libXinerama
    xorg.libXi
    xorg.libxcb
    libxkbcommon
    xorg.libxkbfile
  ];

  meta = {
    description = "A multi-platform C library to provide global keyboard and mouse hooks from userland.";
    homepage = "https://github.com/kwhat/libuiohook";
    license = lib.licenses.lgpl3Plus;
  };

}