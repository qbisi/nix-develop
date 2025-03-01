{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchPypi,
  python,

  # build-system
  setuptools,
  cython,
  pybind11,

  # dependencies
  mpi,
  cachetools,
  decorator,
  mpi4py,
  h5py,
  petsc4py,
  numpy,
  packaging,
  pkgconfig,
  progress,
  pycparser,
  pytools,
  requests,
  rtree,
  scipy,
  sympy,
  fenics-ufl,
  fenics-fiat,
  pyadjoint-ad,
  loopy,
  libsupermesh,

  # lint
  flake8,
  pylint,

  # doc
  sphinx,
  sphinx-autobuild,
  sphinxcontrib-bibtex,
  # not available in nixpkgs
  # sphinxcontrib-svg2pdfconverter,
  sphinxcontrib-jquery,
  bibtexparser,
  sphinxcontrib-youtube,
  numpydoc,

  # tests
  pylit,
  nbval,
  pytest,
  pytest-mpi,
  pytest-xdist,
  pytestCheckHook,
  mpiCheckPhaseHook,
}:
buildPythonPackage rec {
  version = "20250218.0";
  pname = "firedrake";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "firedrake";
    tag = "Firedrake_${version}";
    sha256 = "sha256-7AYJ1fhXe36V/zrD8aYZz7V/D4G2y2nwxhJ/72in29k=";
  };

  build-system = [
    decorator # This duplicated decorator ensures decorator-4.4.2 take predence
    setuptools
    cython
    pybind11
  ];

  dependencies = [
    mpi
    decorator
    cachetools
    mpi4py
    h5py
    petsc4py
    numpy
    packaging
    pkgconfig
    progress
    pycparser
    pytools
    requests
    rtree
    scipy
    sympy
    fenics-ufl
    fenics-fiat
    pyadjoint-ad
    loopy
    libsupermesh
  ];

  # user need the mpi compiler mpicc to compile the generated code
  propagatedUserEnvPkgs = [ (lib.getDev mpi) ];

  optional-dependencies = {
    dev = [
      flake8
      pylint
    ];

    test = [
      pylit
      nbval
      pytest
      pytest-mpi
      pytest-xdist
    ];

    docs = [
      sphinx
      sphinx-autobuild
      sphinxcontrib-bibtex
      # not available in nixpkgs
      # sphinxcontrib-svg2pdfconverter
      sphinxcontrib-jquery
      bibtexparser
      sphinxcontrib-youtube
      numpydoc
    ];
  };

  postInstall = ''
    export HOME="$(mktemp -d)"
  '';

  #ImportError: cannot import name 'sparsity' from partially initialized modules
  doCheck = false;

  nativeCheckInputs = [
    pytestCheckHook
    mpiCheckPhaseHook
  ] ++ optional-dependencies.test;


  pythonImportsCheck = [ "firedrake" ];
  nativeInstallCheckInputs = [ mpiCheckPhaseHook ];

  meta = {
    homepage = "http://www.firedrakeproject.org";
    description = "Automated system for the portable solution of partial differential equations using the finite element method (FEM)";
    changelog = "https://github.com/firedrakeproject/firedrake/releases/tag/${src.tag}";
    license = lib.licenses.lgpl3;
    maintainers = with lib.maintainers; [ qbisi ];
  };
}
