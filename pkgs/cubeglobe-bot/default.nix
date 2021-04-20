{ stdenv, lib, fetchFromGitHub, pkgs, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "cubeglobe-bot";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "DeeUnderscore";
    repo = "cubeglobe-bot";
    rev = "v${version}";
    sha256 = "1n1nxqiybabb98nzs4s30c8430fk2vhclfw2hsk1gbw9v22vzwxa";
    fetchSubmodules = true;
  };

  cargoSha256 = "007z4p2qy5gg3kkz5npc5wjhr4niw0qnm32a756m1696hxmn98wa";

  nativeBuildInputs = with pkgs; [
    pkgconfig
  ];

  buildInputs = with pkgs; [
    openssl
    SDL2
    SDL2_image
  ];

  doCheck = false;

  postInstall = ''
    mkdir -p $out/share/cubeglobe
    cp -R cubeglobe/assets $out/share/cubeglobe/
    substituteInPlace $out/share/cubeglobe/assets/full-tiles.toml --replace "assets/" "$out/share/cubeglobe/assets/"
  '';

  meta = with lib; {
    description = "Fediverse bot for posting randomly generated landscapes made of blocks";
    homepage = "https://github.com/DeeUnderscore/cubeglobe-bot/";
    license = licenses.isc;
  };
}