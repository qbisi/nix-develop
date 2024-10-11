{ lib
, fetchFromGitHub
, pythonPackages
}:

pythonPackages.buildPythonPackage rec {
  version = "0-unstable-2024-08-03";
  name = "Irksome";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "irksome";
    rev = "ed30518f2ca30dfb54030fbba5191384fa72c047";
    sha256 = "sha256-JXl6wrTdztVBSDt6waSwUgz5Ocdjb9MFEj+YGs0Vntc=";
  };

  # check requires import firedrake module
  # pythonImportsCheck = [
  #   "irksome"
  # ];

  # nativeCheckInputs = with pythonPackages; [ pytestCheckHook mpi4py fiat ufl];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/irksome";
    description = "Generate Runge-Kutta methods from a semi-discrete UFL form.";
    license = licenses.lgpl3;
  };
}
