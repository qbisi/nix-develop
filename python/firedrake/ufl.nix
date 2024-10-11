{ lib, fetchFromGitHub, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  version = "20240829.0";
  name = "firedrake-ufl-${version}";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "ufl";
    rev = "Firedrake_${version}";
    sha256 = "sha256-ofAFGc9IfZ8sQRuwsUg2zkLojTIryxwcQ+4l6jPfXD4=";
  };

  build-system = with pythonPackages; [ pip setuptools ];

  dependencies = with pythonPackages; [
    numpy
  ];

  pythonImportsCheck = [
    "ufl"
    "ufl.algorithms"
    "ufl.core"
    "ufl.corealg"
    "ufl.formatting"
    "ufl.utils"
  ];

  nativeCheckInputs = with pythonPackages; [ pytestCheckHook ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/ufl";
    description = "Copy of upstream UFL for use with Firedrake.";
    license = licenses.lgpl3;
  };
}
