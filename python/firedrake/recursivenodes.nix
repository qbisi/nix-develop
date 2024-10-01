{ lib, fetchFromGitLab, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  version = "0.3.0";
  name = "recursivenodes";
  pyproject = true;


  src = fetchFromGitLab {
    owner = "tisaac";
    repo = name;
    rev = "5c0b4695605b8e4013190cf1bf244d960823cb50";
    hash = "sha256-RThTrYxM4dvTclUZrnne1q1ij9k6aJEeYKTZaxqzs5g=";
  };

  build-system = with pythonPackages; [ setuptools ];

  dependencies = with pythonPackages; [
    numpy
    scipy
  ];

  pythonImportsCheck = [ "recursivenodes" ];

  meta = with lib; {
    homepage = "https://tisaac.gitlab.io/recursivenodes/";
    description = "Recursive, parameter-free, explicitly defined interpolation nodes for simplices.";
    license = licenses.mit;
  };
}
