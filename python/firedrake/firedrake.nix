{ lib
, fetchFromGitHub
, python3
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
, pyadjoint
, pytest-mpi
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
    cython
  ];

  dependencies = with pythonPackages; [
    libspatialindex
    libsupermesh
    hdf5
    numpy
    scipy
    sympy
    rtree
    pybind11
    h5py
    progress
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
    pyadjoint
  ];

  PETSC_DIR = "${petsc}";

  configuration = builtins.toJSON {
    options = {
      # package_manager = true;
      # minimal_petsc = false;
      # mpicc = null;
      # mpicxx = null;
      # mpif90 = null;
      # mpiexec = null;
      # disable_ssh = true;
      honour_petsc_dir = true;
      # with_parmetis = true;
      # slepc = false;
      # packages = [ ];
      # honour_pythonpath = true;
      # opencascade = false;
      # tinyasm = false;
      # petsc_int_type = "int32";
      cache_dir = "/tmp/firedrake";
      complex = false;
      # remove_build_files = false;
      # with_blas = null;
      # torch = false;
      # netgen = false;
    };
    # environment = { };
    # additions = [ ];
  };

  passAsFile = [ "configuration" ];

  preInstallCheck = ''
    cd $out
    install -Dm 644 $configurationPath $out/${python3.sitePackages}/firedrake_configuration/configuration.json
    export HOME="$(mktemp -d)"
  '';

  pythonImportsCheck = [
    "firedrake"
  ];

  # doCheck = false;

  pytestFlagsArray = [
    # "--numprocesses=$NIX_BUILD_CORES"
    # "$OLDPWD/tests/multigrid/"
  ];

  disabledTests = [
    # "test_multi_space_transfer"
  ];

  nativeCheckInputs = with pythonPackages; [
    # pytestCheckHook
    # pytest-mpi
    # pytest-xdist
  ];

  meta = with lib; {
    homepage = "http://www.firedrakeproject.org";
    description = "Firedrake is an automated system for the portable solution of partial differential equations using the finite element method (FEM).";
    license = licenses.lgpl3;
  };
}
