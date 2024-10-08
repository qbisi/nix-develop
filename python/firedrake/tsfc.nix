{ lib
, callPackage
, fetchFromGitHub
, pythonPackages
, loopy
, finat
}:

pythonPackages.buildPythonPackage rec {
  version = "20240829.0";
  name = "firedrake-tsfc-${version}";

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "tsfc";
    rev = "Firedrake_${version}";
    sha256 = "sha256-P3bANMPvPoqJiuy1nd6wpyd7PxN1vsdmglwu2UKtwWk=";
  };

  dependencies = [
    pythonPackages.numpy
    loopy
    finat
  ];

  preInstallCheck = ''
    export HOME="$(mktemp -d)"
  '';

  pythonImportsCheck = [
    "gem"
    "tsfc"
    "tsfc.kernel_interface"
  ];

  nativeCheckInputs = with pythonPackages; [ pytestCheckHook ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/tsfc";
    description = "Form compiler for the Firedrake project.";
    license = licenses.gpl3;
  };
}
