{ lib, fetchFromGitHub, pythonPackages, recursivenodes }:

pythonPackages.buildPythonPackage rec {
  version = "20240829.0";
  name = "firedrake-fiat-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "fiat";
    rev = "Firedrake_${version}";
    sha256 = "sha256-qBfJ2aUMsgMR4hERoD6E+rBf0LhzUI7Bj3tHggnVRnI=";
  };

  dependencies = with pythonPackages; [
    numpy
    scipy
    sympy
    recursivenodes
    setuptools
  ];

  pythonImportsCheck = [ "FIAT" ];

  nativeCheckInputs = with pythonPackages; [ pytestCheckHook ];

  disabledTestPaths = [
    # need externel data download
    "test/regression/"
  ];

  meta = with lib;
    {
      homepage = "https://github.com/firedrakeproject/fiat";
      description = "Copy of upstream FIAT for use with Firedrake.";
      license = licenses.lgpl3;
    };
}
