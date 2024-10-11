{ lib
, fetchFromGitHub
, pythonPackages
, checkpoint_schedules
}:

pythonPackages.buildPythonPackage rec {
  version = "0-unstable-2024-10-03";
  name = "dolfin-adjoint";

  src = fetchFromGitHub {
    owner = "dolfin-adjoint";
    repo = "pyadjoint";
    rev = "b9574fbd2c36f47da66e226854e997decf32bbf8";
    sha256 = "sha256-ST57z2a85/uOg4+WCftWmbPpPe9qm1XTRj8rno94jzs=";
  };

  dependencies = [
    pythonPackages.numpy
    pythonPackages.scipy
    checkpoint_schedules
  ];

  pythonImportsCheck = [
    "pyadjoint"
    # need import firedrake
    # "firedrake_adjoint"
    "numpy_adjoint"
    "pyadjoint.optimization"
  ];

  disabledTestPaths = [
    # need import fenics
    "tests/fenics_adjoint/"
    # need import dolfin_adjoint
    "tests/migration/timeforms/"
  ];

  nativeCheckInputs = with pythonPackages; [ pytestCheckHook ];

  meta = with lib; {
    homepage = "https://github.com/dolfin-adjoint/pyadjoint";
    description = "An operator-overloading algorithmic differentiation framework for Python.";
    license = licenses.lgpl3;
  };
}
