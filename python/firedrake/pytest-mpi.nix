{ lib
, fetchFromGitHub
, pythonPackages
}:

pythonPackages.buildPythonPackage rec {
  version = "0-unstable-2024-10-04";
  name = "pytest-mpi";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "pytest-mpi";
    rev = "f4a9692cd3e874606f95da53f18f40087a914863";
    sha256 = "sha256-PUnnsKpeoR/rwNY07q7tEhHTDlc1o2qH5+xLQr5o2fs=";
  };

  build-system = with pythonPackages; [
    hatchling
    editables
  ];

  dependencies = with pythonPackages; [
    mpi4py
    pytest
  ];

  pythonImportsCheck = [
    "pytest_mpi"
  ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/pytest-mpi";
    description = "Pytest plugin that lets you run tests in parallel with MPI.";
    license = licenses.gpl3;
  };
}
