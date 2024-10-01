{ lib
, callPackage
, fetchFromGitHub
, pythonPackages
, pulp
}:

pythonPackages.buildPythonPackage rec {
  version = "20230510.0";
  name = "firedrake-COFFEE-${version}";

  src = fetchFromGitHub {
    owner = "coneoproject";
    repo = "COFFEE";
    rev = "Firedrake_${version}";
    sha256 = "sha256-av3JLE6o4v3VhJKMm5FiWjtdb3mRBZ1Xhjz2CkUCa5A=";
  };

  dependencies = with pythonPackages; [
    networkx
    numpy
    six
    pulp
  ];

  pythonImportsCheck = [ "coffee" "coffee.visitors" ];

  meta = with lib; {
    homepage = "https://github.com/coneoproject/COFFEE";
    description = "A COmpiler For Fast Expression Evaluation (COFFEE).";
    license = licenses.bsd3;
  };
}
