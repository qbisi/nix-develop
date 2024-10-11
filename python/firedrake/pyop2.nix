{ lib
, fetchFromGitHub
, pythonPackages
, mpi
, coffee
, petsc
, petsc4py
, loopy
}:

pythonPackages.buildPythonPackage rec {
  version = "20240829.0";
  name = "PyOP2-${version}";

  src = fetchFromGitHub {
    owner = "OP2";
    repo = "PyOP2";
    rev = "Firedrake_${version}";
    sha256 = "sha256-KFqim2IWPekTr0WNF7cs1zWrjlD08O9U3nJ0E7mtdZg=";
  };

  build-system = with pythonPackages; [
    setuptools
    cython
    mpi
  ];

  dependencies = [
    pythonPackages.packaging
    pythonPackages.mpi4py
    pythonPackages.numpy
    pythonPackages.cachetools
    petsc4py
    loopy
    petsc
  ];

  PETSC_DIR = "${petsc}";

  preInstallCheck = ''
    export HOME="$(mktemp -d)"
  '';

  pythonImportsCheck = [ "pyop2" "pyop2.codegen" "pyop2.types" "pyop2.sparsity"];

  # pytest check failed
  # nativeCheckInputs = with pythonPackages; [ pytestCheckHook flake8 ];

  meta = with lib; {
    homepage = "http://op2.github.io/PyOP2/";
    description = "Framework for performance-portable parallel computations on unstructured meshes.";
    license = licenses.bsd3;
  };
}
