{ lib
, fetchFromGitHub
, pythonPackages
, libspatialindex
, libsupermesh
, hdf5
, mpi
, ufl
, fiat
, finat
, tsfc
, pyop2
, petsc
, petsc4py
, coffee
}:

pythonPackages.buildPythonPackage rec {
  version = "20240829.0";
  name = "firedrake-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "firedrake";
    rev = "Firedrake_${version}";
    sha256 = "sha256-CR6Aj4RdVvMkMDevJjY9Kl/brFI809DeOLDMXFyRkaQ=";
  };

  build-system = with pythonPackages; [
    mpi
    libspatialindex
    libsupermesh
    cython
  ];

  dependencies = with pythonPackages; [
    hdf5
    numpy
    scipy
    sympy
    rtree
    # h5py
    # pythonPackages.six
    # pythonPackages.sympy
    # pythonPackages.psutil
    # pythonPackages.cachetools
    # pythonPackages.singledispatch
    # pythonPackages.ipython
    # pythonPackages.matplotlib
    ufl
    fiat
    finat
    tsfc
    pyop2
    petsc
    petsc4py
    coffee
  ];

  PETSC_DIR = "${petsc}";

  meta = with lib; {
    homepage = "http://www.firedrakeproject.org";
    description = "Firedrake is an automated system for the portable solution of partial differential equations using the finite element method (FEM).";
    license = licenses.gpl3;
  };
}
