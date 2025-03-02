{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  pkgs,
  pkg-config,
  ninja,
  libcstdaux,
}:

stdenv.mkDerivation rec {
  pname = "libcsiphash";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "c-util";
    repo = "c-siphash";
    tag = "v${version}";
    sha256 = "sha256-S5eAlLR6p0Tpd6aYPGGGOH1sCGOyflVyhICi2pYt/8U=";
  };

  patches = [
    (fetchpatch {
      name = "libcsiphash-meson-fixup";
      url = "https://github.com/c-util/c-siphash/commit/af595789bec83a8c76a66e6a20a9d005f2d2f948.patch";
      hash = "sha256-xi2PpXAVYBA2mXz5ugqeAoh18OVI7cD8nvbPvFF9bfI=";
    })
  ];

  nativeBuildInputs = [
    pkgs.meson
    pkg-config
    ninja
  ];

  buildInputs = [ libcstdaux ];

  doCheck = true;

  meta = {
    homepage = "https://github.com/c-util/c-siphash";
    description = "Streaming-capable SipHash Implementation";
    license = with lib.licenses; [
      asl20
      lgpl2Plus
    ];
    maintainers = with lib.maintainers; [ qbisi ];
  };
}
