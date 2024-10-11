{ lib
, callPackage
, pythonPackages
, mpi
, petsc
}:

pythonPackages.buildPythonPackage rec {
  inherit (petsc) version src;
  name = "petsc4py";

  sourceRoot = "source/src/binding/petsc4py";

  build-system = with pythonPackages; [
    setuptools
    cython
    mpi
  ];

  dependencies = with pythonPackages; [
    numpy
    petsc
  ];

  PETSC_DIR = "${petsc}";

  nativeCheckInputs = [
    pythonPackages.unittestCheckHook
  ];

  unittestFlagsArray = [
    "-s"
    "test"
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://gitlab.com/petsc/petsc4py";
    description = "Python bindings for PETSc.";
    license = licenses.bsd2;
  };
}
