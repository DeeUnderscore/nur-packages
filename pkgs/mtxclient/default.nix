# This file is a modified version of nixpkgs/pkgs/development/libraries/mtxclient/default.nix (copied at 5c4b9be)

{ lib, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, openssl
, olm
, spdlog
, nlohmann_json
, libevent
, curl
, coeurl
, re2
}:
stdenv.mkDerivation {
  pname = "mtxclient";
  version = "unstable-2024-06-11";

  src = fetchFromGitHub {
    owner = "Nheko-Reborn";
    repo = "mtxclient";
    rev = "e87c6f4f7aa8fc8e5b1640454e8c94a4efd36e8a";
    hash = "sha256-uIppA6FzWqPhXSQAnoiYi78NSA8+gpYf01E9XdLrvpU=";
  };

  cmakeFlags = [
    # Network requiring tests can't be disabled individually:
    # https://github.com/Nheko-Reborn/mtxclient/issues/22
    "-DBUILD_LIB_TESTS=OFF"
    "-DBUILD_LIB_EXAMPLES=OFF"
  ];

  postPatch = ''
    # See https://github.com/gabime/spdlog/issues/1897
    sed -i '1a add_compile_definitions(SPDLOG_FMT_EXTERNAL)' CMakeLists.txt
  '';


  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    spdlog
    nlohmann_json
    openssl
    olm
    libevent
    curl
    coeurl
    re2
  ];

  meta = with lib; {
    description = "Client API library for Matrix, built on top of Boost.Asio";
    homepage = "https://github.com/Nheko-Reborn/mtxclient";
    license = licenses.mit;
    platforms = platforms.all;
    # Should be fixable if a higher clang version is used, see:
    # https://github.com/NixOS/nixpkgs/pull/85922#issuecomment-619287177
    broken = stdenv.targetPlatform.isDarwin;
  };
}
