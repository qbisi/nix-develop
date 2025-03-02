{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  setuptools,
  mpi4py,
  mpi,
  pytest,
  pytestCheckHook,
  mpiCheckPhaseHook,
}:

buildPythonPackage rec {
  version = "2025.2.0";
  pname = "mpi-pytest";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "mpi-pytest";
    tag = "v${version}";
    sha256 = "sha256-8VRzLK5RrRgmdkBFLAcG2Ehf/4qKpj1j4FymfmGgTZg=";
  };

  build-system = [ setuptools ];

  dependencies = [
    mpi
    mpi4py
    pytest
  ];

  propagatedUserEnvPkgs = [
    mpi
  ];

  pythonImportsCheck = [
    "pytest_mpi"
  ];

  nativeCheckInputs = [
    pytestCheckHook
    mpiCheckPhaseHook
  ];

  doCheck = false;

  pytestCheckPhase = ''
    mpiexec -n 2 pytest -m "parallel[2]"
  '';

  meta = {
    homepage = "https://github.com/firedrakeproject/mpi-pytest";
    description = "Pytest plugin that lets you run tests in parallel with MPI";
    changelog = "https://github.com/firedrakeproject/mpi-pytest/releases/tag/${src.tag}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ qbisi ];
  };
}
