{ lib
, stdenv
, fetchFromGitHub
, gfortran
, mpi
, cmake
, libspatialindex
}:

stdenv.mkDerivation rec {
  pname = "libsupermesh";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "libsupermesh";
    rev = "c07de1307e12266707189645fed0f604dab44150";
    hash = "sha256-qpmasReoqZuNWTt0Pj3WofCRCZrrREp6iSHi6Z1w21o=";
  };

  nativeBuildInputs = [ gfortran cmake mpi ];

  buildInputs = [ libspatialindex gfortran.cc.lib ];

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=ON"
  ];

  # doCheck = true;

  meta = {
    description = "Parallel supermeshing library.";
    homepage = "https://github.com/firedrakeproject/libsupermesh";
    license = with lib.licenses; [ lgpl2 ];
  };
}
