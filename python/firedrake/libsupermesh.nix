{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  gfortran,
  mpi,
  cmake,
  ninja,
  libspatialindex,
  scikit-build-core,
  rtree,
}:

buildPythonPackage rec {
  pname = "libsupermesh";
  version = "0-unstable-2024-12-20";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "libsupermesh";
    rev = "f87cbfdad9edeb12d47118e13564d45f66876322";
    hash = "sha256-9b5tIfaWQqlbEOjRP4wIkX80jVJshDi1T4ghjk92WuA=";
  };

  build-system = [
    gfortran
    cmake
    ninja
    mpi
    scikit-build-core
  ];

  dontUseCmakeConfigure = true;

  buildInputs = [
    libspatialindex
    gfortran.cc.lib
  ];

  dependencies = [
    rtree
  ];

  meta = {
    homepage = "https://github.com/firedrakeproject/libsupermesh";
    description = "Parallel supermeshing library";
    license = lib.licenses.lgpl2;
    maintainers = with lib.maintainers; [ qbisi ];
  };
}
