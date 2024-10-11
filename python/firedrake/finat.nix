{ lib
, callPackage
, fetchFromGitHub
, pythonPackages
, fiat
, ufl
, tsfc_0
}:

pythonPackages.buildPythonPackage rec {
  version = "20240829.0";
  name = "FInAT-${version}";

  src = fetchFromGitHub {
    owner = "FInAT";
    repo = "FInAT";
    rev = "Firedrake_${version}";
    sha256 = "sha256-ouqRC0pP37k124Bkmo2uwDuTBIlc0mphzyNxqzvct6g=";
  };

  build-system = [ tsfc_0 ];

  dependencies = [
    pythonPackages.numpy
    pythonPackages.symengine
    pythonPackages.sympy
    fiat
    ufl
  ];

  pythonImportsCheck = [ "finat" "finat.ufl" ];

  nativeCheckInputs = with pythonPackages; [ pytestCheckHook ];

  meta = with lib; {
    homepage = "https://github.com/FInAT/FInAT";
    description = "FInAT is an attempt to provide a more abstract, smarter library of finite elements.";
    license = licenses.mit;
  };
}
