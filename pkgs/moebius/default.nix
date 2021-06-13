{ pkgs
, system
, nodejs
, fetchFromGitHub
, lib
, stdenv
, makeWrapper
, electron_9 }:
let 
  nodePackages = import ./node-composition.nix {
    inherit pkgs system nodejs;
  };
  electron = electron_9;
in stdenv.mkDerivation rec {
  pname = "moebius";
  version = "1.0.29"; # make sure to check ./update-dependencies.sh on update!

  src = fetchFromGitHub {
    owner = "blocktronics";
    repo = "moebius";
    rev = version;
    sha256 = "16154kfl3d03jd836hywbiskdr0yf1ijd2f7m4df220ng8kgl0f9";
  };


  buildInputs = [
    nodejs
    electron
    makeWrapper
  ];

  dontBuild = true;


  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/${pname}

    cp -r ${nodePackages.shell.nodeDependencies}/lib/node_modules $out/share/${pname}/
    cp -r app $out/share/${pname}/
    cp -r build $out/share/${pname}/
    cp package.json $out/share/${pname}

    makeWrapper ${electron}/bin/electron $out/bin/moebius \
      --add-flags $out/share/${pname}

    runHook postInstall
  '';

  meta = {
    description = "Modern ANSI & ASCII Art Editor";
    homepage = "https://blocktronics.github.io/moebius/";
    license = lib.licenses.asl20;
  };

}