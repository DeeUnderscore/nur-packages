{ stdenv
, lib
, writeText
, fetchFromGitHub
, obs-studio
, libuiohook
} :
let 
  inputOverlaySrc = fetchFromGitHub {
    owner = "univrsal";
    repo = "input-overlay";
    rev = "v4.8";
    sha256 = "1dklg0dx9ijwyhgwcaqz859rbpaivmqxqvh9w3h4byrh5pnkz8bf";
    fetchSubmodules = true;
  };
  patchedPluginsCMakeLists = writeText "CMakeLists.txt" ''
    add_subdirectory(input-overlay)
  '';
in obs-studio.overrideAttrs (oldAttrs: rec {
  name = "input-overlay-4.8";
  buildInputs = oldAttrs.buildInputs ++ [ libuiohook ];

  postUnpack = (if (builtins.hasAttr "postUnpack" oldAttrs) then oldAttrs.postUnpack else "") + "\n" + ''
    cp -r ${inputOverlaySrc}/ source/plugins/input-overlay
    chmod -R u+w source/plugins/input-overlay 
    cp ${patchedPluginsCMakeLists} source/plugins/CMakeLists.txt
  '';

  cmakeFlags = [
    "-DCMAKE_CXX_FLAGS=-DDL_OPENGL=\\\"$(out)/lib/libobs-opengl.so\\\""
    "-Wno-dev" # kill dev warnings that are useless for packaging
    "-DBUILD_BROWSER=OFF"
    "-DCEF_ROOT_DIR=../../cef"
  ];

  installPhase = ''
    mkdir $out
    mkdir -p $out/data

    cp -r rundir/Release/data/obs-plugins/input-overlay/* $out/data/
  '' + lib.optionalString (stdenv.is64bit) ''
    mkdir -p $out/bin/64bit
    cp rundir/Release/obs-plugins/64bit/input-overlay.so $out/bin/64bit
  '' + lib.optionalString (stdenv.is32bit) ''
    mkdir -p $out/bin/32bit
    cp rundir/Release/obs-plugins/32bit/input-overlay.so $out/bin/32bit
  '';

  postFixup = lib.optionalString (stdenv.is64bit) ''
    addOpenGLRunpath $out/bin/64bit/input-overlay.so
  '' + lib.optionalString (stdenv.is32bit) ''
    addOpenGLRunpath $out/bin/32bit/input-overlay.so
  '';

})
